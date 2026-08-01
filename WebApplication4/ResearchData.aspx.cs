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
                        ddlImpactFactor.SelectedValue = dr["ImpactFactor"].ToString();
                        txtHECPublications.Text = dr["HECPublications"].ToString();
                        ddlConferencePaper.SelectedValue = dr["ConferencePaper"].ToString();
                        ddlImpactFactor2.SelectedValue = dr["ImpactFactor2"].ToString();
                        ddlConferencePaper2.SelectedValue = dr["ConferencePaper2"].ToString();
                        txtWCount.Text = dr["WCount"].ToString();
                        txtXCount.Text = dr["XCount"].ToString();
                        txtYCount.Text = dr["YCount"].ToString();
                        txtTotalFundedProjects.Text = dr["TotalFundedProjects"].ToString();
                        txtPIProjects.Text = dr["PIProjects"].ToString();
                        txtCoPIProjects.Text = dr["CoPIProjects"].ToString();
                        txtMSStudents.Text = dr["MSStudents"].ToString();
                        txtMPhilStudents.Text = dr["MPhilStudents"].ToString();
                        txtPhDStudents.Text = dr["PhDStudents"].ToString();
                    }
                    else
                    {
                        // No profile exists yet, leave fields empty
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

            string query = @"
INSERT INTO Publications
(
    user_id,
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
    @ArticleTitle,
    @Authors,
    @JournalName,
    @PublicationDate,
    @PublicationYear,
    @DOI
)";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userID;
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

            // Check if profile exists
            string checkQuery = "SELECT COUNT(*) FROM ResearchProfile WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                    int exists = (int)checkCmd.ExecuteScalar();

                    string query;
                    if (exists > 0)
                    {
                        // Update existing profile
                        query = @"
UPDATE ResearchProfile SET
    ImpactFactor = @ImpactFactor,
    HECPublications = @HECPublications,
    ConferencePaper = @ConferencePaper,
    ImpactFactor2 = @ImpactFactor2,
    ConferencePaper2 = @ConferencePaper2,
    WCount = @WCount,
    XCount = @XCount,
    YCount = @YCount,
    TotalFundedProjects = @TotalFundedProjects,
    PIProjects = @PIProjects,
    CoPIProjects = @CoPIProjects,
    MSStudents = @MSStudents,
    MPhilStudents = @MPhilStudents,
    PhDStudents = @PhDStudents,
    UpdatedAt = GETDATE()
WHERE user_id = @userID";
                    }
                    else
                    {
                        // Insert new profile
                        query = @"
INSERT INTO ResearchProfile
(
    user_id,
    ImpactFactor,
    HECPublications,
    ConferencePaper,
    ImpactFactor2,
    ConferencePaper2,
    WCount,
    XCount,
    YCount,
    TotalFundedProjects,
    PIProjects,
    CoPIProjects,
    MSStudents,
    MPhilStudents,
    PhDStudents
)
VALUES
(
    @userID,
    @ImpactFactor,
    @HECPublications,
    @ConferencePaper,
    @ImpactFactor2,
    @ConferencePaper2,
    @WCount,
    @XCount,
    @YCount,
    @TotalFundedProjects,
    @PIProjects,
    @CoPIProjects,
    @MSStudents,
    @MPhilStudents,
    @PhDStudents
)";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                        cmd.Parameters.Add("@ImpactFactor", SqlDbType.VarChar).Value = ddlImpactFactor.SelectedValue;
                        cmd.Parameters.Add("@HECPublications", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtHECPublications.Text) ? 0 : Convert.ToInt32(txtHECPublications.Text.Trim());
                        cmd.Parameters.Add("@ConferencePaper", SqlDbType.VarChar).Value = ddlConferencePaper.SelectedValue;
                        cmd.Parameters.Add("@ImpactFactor2", SqlDbType.VarChar).Value = ddlImpactFactor2.SelectedValue;
                        cmd.Parameters.Add("@ConferencePaper2", SqlDbType.VarChar).Value = ddlConferencePaper2.SelectedValue;
                        cmd.Parameters.Add("@WCount", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtWCount.Text) ? 0 : Convert.ToInt32(txtWCount.Text.Trim());
                        cmd.Parameters.Add("@XCount", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtXCount.Text) ? 0 : Convert.ToInt32(txtXCount.Text.Trim());
                        cmd.Parameters.Add("@YCount", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtYCount.Text) ? 0 : Convert.ToInt32(txtYCount.Text.Trim());
                        cmd.Parameters.Add("@TotalFundedProjects", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtTotalFundedProjects.Text) ? 0 : Convert.ToInt32(txtTotalFundedProjects.Text.Trim());
                        cmd.Parameters.Add("@PIProjects", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtPIProjects.Text) ? 0 : Convert.ToInt32(txtPIProjects.Text.Trim());
                        cmd.Parameters.Add("@CoPIProjects", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtCoPIProjects.Text) ? 0 : Convert.ToInt32(txtCoPIProjects.Text.Trim());
                        cmd.Parameters.Add("@MSStudents", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtMSStudents.Text) ? 0 : Convert.ToInt32(txtMSStudents.Text.Trim());
                        cmd.Parameters.Add("@MPhilStudents", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtMPhilStudents.Text) ? 0 : Convert.ToInt32(txtMPhilStudents.Text.Trim());
                        cmd.Parameters.Add("@PhDStudents", SqlDbType.Int).Value =
                            string.IsNullOrWhiteSpace(txtPhDStudents.Text) ? 0 : Convert.ToInt32(txtPhDStudents.Text.Trim());

                        cmd.ExecuteNonQuery();
                    }
                }
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
                lblMessage.Text = "Journal Name is required.";
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
                // First save the research profile (One-to-One)
                SaveResearchProfile();

                // Then add the publication (One-to-Many)
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
            ddlImpactFactor.SelectedIndex = 0;
            txtHECPublications.Text = string.Empty;
            ddlConferencePaper.SelectedIndex = 0;
            ddlImpactFactor2.SelectedIndex = 0;
            ddlConferencePaper2.SelectedIndex = 0;
            txtWCount.Text = string.Empty;
            txtXCount.Text = string.Empty;
            txtYCount.Text = string.Empty;
            txtTotalFundedProjects.Text = string.Empty;
            txtPIProjects.Text = string.Empty;
            txtCoPIProjects.Text = string.Empty;
            txtMSStudents.Text = string.Empty;
            txtMPhilStudents.Text = string.Empty;
            txtPhDStudents.Text = string.Empty;
        }

        protected void ClearPublicationFields()
        {
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
            // Save research profile before moving to next page
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