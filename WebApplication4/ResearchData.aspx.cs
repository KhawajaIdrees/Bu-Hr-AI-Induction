using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class ResearchData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadResearchProfile();
                LoadPublications();
            }
        }

        // Load Research Profile (One-to-One)
        protected void LoadResearchProfile()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT * FROM ResearchProfile WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        // Research Summary
                        try { txtTotalPublications.Text = dr["TotalPublications"].ToString(); } catch { txtTotalPublications.Text = "0"; }
                        try { txtHECPublications.Text = dr["HECPublications"].ToString(); } catch { txtHECPublications.Text = "0"; }

                        // MS/M.Phil Produced - Using combined column
                        try { txtMSMPhilStudents.Text = dr["MSMPhilStudents"].ToString(); } catch { txtMSMPhilStudents.Text = "0"; }
                        try { txtPhDStudents.Text = dr["PhDStudents"].ToString(); } catch { txtPhDStudents.Text = "0"; }

                        // Funded Projects
                        try { txtPIProjects.Text = dr["PIProjects"].ToString(); } catch { txtPIProjects.Text = "0"; }
                        try { txtCoPIProjects.Text = dr["CoPIProjects"].ToString(); } catch { txtCoPIProjects.Text = "0"; }

                        // Consultancy
                        try { txtConsultancyAmount.Text = dr["ConsultancyAmount"].ToString(); } catch { txtConsultancyAmount.Text = ""; }
                    }
                    else
                    {
                        ClearResearchFields();
                    }
                }
            }
        }

        // Load Publications (One-to-Many)
        protected void LoadPublications()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT 
                                id as PublicationID,
                                PublicationType,
                                Category,
                                Status,
                                ArticleTitle,
                                Authors,
                                JournalName,
                                PublicationDate,
                                PublicationYear,
                                DOI
                            FROM Publications 
                            WHERE user_id = @userID 
                            ORDER BY CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No publications added yet.";
                        gvPublications.Visible = false;
                    }
                    else
                    {
                        gvPublications.Visible = true;
                        lblMessage.Text = "";
                    }

                    gvPublications.DataSource = dt;
                    gvPublications.DataBind();
                }
            }
        }

        // Add Publication (One-to-Many)
        protected void AddPublication()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
INSERT INTO Publications
(
    user_id,
    PublicationType,
    Category,
    Status,
    ArticleTitle,
    Authors,
    JournalName,
    PublicationDate,
    PublicationYear,
    DOI
)
VALUES
(
    @userId,
    @PublicationType,
    @Category,
    @Status,
    @ArticleTitle,
    @Authors,
    @JournalName,
    @PublicationDate,
    @PublicationYear,
    @DOI
)";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userID;
                cmd.Parameters.Add("@PublicationType", SqlDbType.NVarChar).Value = ddlPublicationType.SelectedValue;
                cmd.Parameters.Add("@Category", SqlDbType.NVarChar).Value = ddlCategory.SelectedValue;
                cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = ddlPublicationStatus.SelectedValue;
                cmd.Parameters.Add("@ArticleTitle", SqlDbType.NVarChar).Value = txtArticleTitle.Text.Trim();
                cmd.Parameters.Add("@Authors", SqlDbType.NVarChar).Value = txtAuthors.Text.Trim();
                cmd.Parameters.Add("@JournalName", SqlDbType.NVarChar).Value = txtJournalName.Text.Trim();
                cmd.Parameters.Add("@PublicationDate", SqlDbType.Date).Value =
                    string.IsNullOrWhiteSpace(txtPublicationDate.Text) ? (object)DBNull.Value : Convert.ToDateTime(txtPublicationDate.Text);
                cmd.Parameters.Add("@PublicationYear", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtPublicationYear.Text) ? 0 : Convert.ToInt32(txtPublicationYear.Text.Trim());
                cmd.Parameters.Add("@DOI", SqlDbType.NVarChar).Value =
                    string.IsNullOrWhiteSpace(txtDOI.Text) ? (object)DBNull.Value : txtDOI.Text.Trim();

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // Save Research Profile (One-to-One)
        protected void SaveResearchProfile()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            try
            {
                // Check if profile exists
                string checkQuery = "SELECT COUNT(*) FROM ResearchProfile WHERE user_id = @userID";
                int exists = 0;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                        exists = (int)checkCmd.ExecuteScalar();
                    }
                }

                string query;
                if (exists > 0)
                {
                    query = @"
UPDATE ResearchProfile SET
    TotalPublications = @TotalPublications,
    HECPublications = @HECPublications,
    MSMPhilStudents = @MSMPhilStudents,
    PhDStudents = @PhDStudents,
    PIProjects = @PIProjects,
    CoPIProjects = @CoPIProjects,
    ConsultancyAmount = @ConsultancyAmount,
    UpdatedAt = GETDATE()
WHERE user_id = @userID";
                }
                else
                {
                    query = @"
INSERT INTO ResearchProfile
(
    user_id,
    TotalPublications,
    HECPublications,
    MSMPhilStudents,
    PhDStudents,
    PIProjects,
    CoPIProjects,
    ConsultancyAmount
)
VALUES
(
    @userID,
    @TotalPublications,
    @HECPublications,
    @MSMPhilStudents,
    @PhDStudents,
    @PIProjects,
    @CoPIProjects,
    @ConsultancyAmount
)";
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;

                        cmd.Parameters.Add("@TotalPublications", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtTotalPublications.Text) ? 0 : Convert.ToInt32(txtTotalPublications.Text.Trim());
                        cmd.Parameters.Add("@HECPublications", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtHECPublications.Text) ? 0 : Convert.ToInt32(txtHECPublications.Text.Trim());

                        cmd.Parameters.Add("@MSMPhilStudents", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtMSMPhilStudents.Text) ? 0 : Convert.ToInt32(txtMSMPhilStudents.Text.Trim());
                        cmd.Parameters.Add("@PhDStudents", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtPhDStudents.Text) ? 0 : Convert.ToInt32(txtPhDStudents.Text.Trim());

                        cmd.Parameters.Add("@PIProjects", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtPIProjects.Text) ? 0 : Convert.ToInt32(txtPIProjects.Text.Trim());
                        cmd.Parameters.Add("@CoPIProjects", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtCoPIProjects.Text) ? 0 : Convert.ToInt32(txtCoPIProjects.Text.Trim());

                        cmd.Parameters.Add("@ConsultancyAmount", SqlDbType.NVarChar).Value =
                            string.IsNullOrWhiteSpace(txtConsultancyAmount.Text) ? (object)DBNull.Value : txtConsultancyAmount.Text.Trim();

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("SaveResearchProfile error: " + ex.Message);
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Validate required fields
            if (string.IsNullOrEmpty(ddlPublicationType.SelectedValue))
            {
                lblMessage.Text = "Please select Publication Type.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(ddlCategory.SelectedValue))
            {
                lblMessage.Text = "Please select Category of Publication.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(ddlPublicationStatus.SelectedValue))
            {
                lblMessage.Text = "Please select Publication Status.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(txtArticleTitle.Text.Trim()))
            {
                lblMessage.Text = "Article Title is required.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(txtAuthors.Text.Trim()))
            {
                lblMessage.Text = "Authors are required.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(txtJournalName.Text.Trim()))
            {
                lblMessage.Text = "Journal/Conference Name is required.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            if (string.IsNullOrEmpty(txtPublicationYear.Text.Trim()))
            {
                lblMessage.Text = "Publication Year is required.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            try
            {
                SaveResearchProfile();
                AddPublication();

                lblMessage.Text = "Publication added successfully!";
                lblMessage.CssClass = "ms-3 text-success";
                ClearPublicationFields();
                LoadPublications();
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "Database error: " + ex.Message;
                lblMessage.CssClass = "ms-3 text-danger";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "ms-3 text-danger";
            }
        }

        protected void ClearResearchFields()
        {
            txtTotalPublications.Text = string.Empty;
            txtHECPublications.Text = string.Empty;
            txtMSMPhilStudents.Text = string.Empty;
            txtPhDStudents.Text = string.Empty;
            txtPIProjects.Text = string.Empty;
            txtCoPIProjects.Text = string.Empty;
            txtConsultancyAmount.Text = string.Empty;
        }

        protected void ClearPublicationFields()
        {
            ddlPublicationType.SelectedIndex = 0;
            ddlCategory.SelectedIndex = 0;
            ddlPublicationStatus.SelectedIndex = 0;
            txtArticleTitle.Text = string.Empty;
            txtAuthors.Text = string.Empty;
            txtJournalName.Text = string.Empty;
            txtPublicationDate.Text = string.Empty;
            txtPublicationYear.Text = string.Empty;
            txtDOI.Text = string.Empty;
        }

        protected void gvPublications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (e.CommandName == "DeletePublication")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    GridViewRow row = gvPublications.Rows[index];
                    int publicationId = Convert.ToInt32(row.Cells[0].Text);

                    string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
                    string query = @"DELETE FROM Publications WHERE id = @id AND user_id = @userID";

                    using (SqlConnection con = new SqlConnection(cs))
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = publicationId;
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = Convert.ToInt32(Session["UserID"]);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadPublications();
                    lblMessage.Text = "Publication deleted successfully.";
                    lblMessage.CssClass = "ms-3 text-success";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error deleting: " + ex.Message;
                    lblMessage.CssClass = "ms-3 text-danger";
                }
            }
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                SaveResearchProfile();
                Response.Redirect("Education.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error saving profile: " + ex.Message;
                lblMessage.CssClass = "ms-3 text-danger";
            }
        }
    }
}