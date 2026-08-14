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
                LoadResearchScore();
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

                        // MS/M.Phil Produced - Use correct column name MS_MPhil_Students
                        try { txtMSMPhilStudents.Text = dr["MS_MPhil_Students"].ToString(); } catch { txtMSMPhilStudents.Text = "0"; }
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

        // =========================================
        // LOAD RESEARCH SCORE
        // =========================================
        private void LoadResearchScore()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT ResearchScore FROM ResearchProfile WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    ViewState["ResearchScore"] = Convert.ToInt32(result);
                }
                else
                {
                    ViewState["ResearchScore"] = 0;
                }
            }
        }

        // =========================================
        // CALCULATE RESEARCH SCORE
        // =========================================
        private int CalculateResearchScore()
        {
            int wCount = 0;
            int xCount = 0;
            int yCount = 0;
            int fundedProjects = 0;

            // Get counts from ResearchProfile
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT 
                                ISNULL(WCount, 0) AS WCount, 
                                ISNULL(XCount, 0) AS XCount, 
                                ISNULL(YCount, 0) AS YCount,
                                ISNULL(TotalFundedProjects, 0) AS TotalFundedProjects
                            FROM ResearchProfile 
                            WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        wCount = Convert.ToInt32(reader["WCount"]);
                        xCount = Convert.ToInt32(reader["XCount"]);
                        yCount = Convert.ToInt32(reader["YCount"]);
                        fundedProjects = Convert.ToInt32(reader["TotalFundedProjects"]);
                    }
                }
            }

            // Calculate score: (W × 5) + (X × 3) + (Y × 1) + (Funded Projects × 5)
            int researchScore = (wCount * 5) + (xCount * 3) + (yCount * 1) + (fundedProjects * 5);

            // Cap at 25 marks
            if (researchScore > 25)
                researchScore = 25;

            return researchScore;
        }

        // =========================================
        // SAVE RESEARCH SCORE TO DATABASE
        // =========================================
        private void SaveResearchScore(int userId, int researchScore)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                UPDATE ResearchProfile 
                SET ResearchScore = @ResearchScore, 
                    UpdatedAt = GETDATE() 
                WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userId;
                cmd.Parameters.Add("@ResearchScore", SqlDbType.Int).Value = researchScore;
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // =========================================
        // UPDATE W, X, Y COUNTS FROM PUBLICATIONS
        // =========================================
        private void UpdatePublicationCounts(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                SELECT 
                    COUNT(CASE WHEN Category = 'W' THEN 1 END) AS WCount,
                    COUNT(CASE WHEN Category = 'X' THEN 1 END) AS XCount,
                    COUNT(CASE WHEN Category = 'Y' THEN 1 END) AS YCount
                FROM Publications
                WHERE user_id = @userID";

            int wCount = 0, xCount = 0, yCount = 0;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        wCount = reader["WCount"] != DBNull.Value ? Convert.ToInt32(reader["WCount"]) : 0;
                        xCount = reader["XCount"] != DBNull.Value ? Convert.ToInt32(reader["XCount"]) : 0;
                        yCount = reader["YCount"] != DBNull.Value ? Convert.ToInt32(reader["YCount"]) : 0;
                    }
                }
            }

            string updateQuery = @"
                UPDATE ResearchProfile 
                SET WCount = @WCount, 
                    XCount = @XCount, 
                    YCount = @YCount,
                    UpdatedAt = GETDATE()
                WHERE user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(updateQuery, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;
                cmd.Parameters.Add("@WCount", SqlDbType.Int).Value = wCount;
                cmd.Parameters.Add("@XCount", SqlDbType.Int).Value = xCount;
                cmd.Parameters.Add("@YCount", SqlDbType.Int).Value = yCount;
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // =========================================
        // UPDATE EXPERIENCE SCORE FROM RESEARCH PROFILE
        // =========================================
        private void UpdateExperienceScore(int userId)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            // Get MS and PhD students from ResearchProfile
            int msStudents = 0, phdStudents = 0;
            string query = "SELECT ISNULL(MS_MPhil_Students, 0), ISNULL(PhDStudents, 0) FROM ResearchProfile WHERE user_id = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        msStudents = Convert.ToInt32(reader[0]);
                        phdStudents = Convert.ToInt32(reader[1]);
                    }
                }
            }

            // Calculate Research Supervision Score (MS: 1 each, PhD: 2 each)
            int researchSupervisionScore = (msStudents * 1) + (phdStudents * 2);

            // Get current ExperienceScore from ExperienceScores table
            int experienceScore = 0;
            string expQuery = "SELECT ISNULL(ExperienceScore, 0) FROM ExperienceScores WHERE UserID = @UserID";
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(expQuery, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != DBNull.Value)
                    experienceScore = Convert.ToInt32(result);
            }

            // Total Experience Score
            int totalExperienceScore = experienceScore + researchSupervisionScore;

            // Cap at 25
            if (totalExperienceScore > 25) totalExperienceScore = 25;

            // Update ExperienceScores table
            string updateQuery = @"
                UPDATE ExperienceScores 
                SET ResearchScore = @ResearchScore, 
                    TotalExperienceScore = @TotalExperienceScore,
                    UpdatedAt = GETDATE()
                WHERE UserID = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(updateQuery, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ResearchScore", researchSupervisionScore);
                cmd.Parameters.AddWithValue("@TotalExperienceScore", totalExperienceScore);
                con.Open();
                cmd.ExecuteNonQuery();
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

            // Update W, X, Y counts after adding publication
            UpdatePublicationCounts(userID);

            // Recalculate and save research score
            int researchScore = CalculateResearchScore();
            SaveResearchScore(userID, researchScore);

            // UPDATE EXPERIENCE SCORE
            UpdateExperienceScore(userID);
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
    MS_MPhil_Students = @MSMPhilStudents,
    PhDStudents = @PhDStudents,
    PIProjects = @PIProjects,
    CoPIProjects = @CoPIProjects,
    ConsultancyAmount = @ConsultancyAmount,
    TotalFundedProjects = @TotalFundedProjects,
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
    MS_MPhil_Students,
    PhDStudents,
    PIProjects,
    CoPIProjects,
    ConsultancyAmount,
    TotalFundedProjects
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
    @ConsultancyAmount,
    @TotalFundedProjects
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

                        // Save Total Funded Projects (PI + Co-PI)
                        int piProjects = string.IsNullOrWhiteSpace(txtPIProjects.Text) ? 0 : Convert.ToInt32(txtPIProjects.Text.Trim());
                        int coPiProjects = string.IsNullOrWhiteSpace(txtCoPIProjects.Text) ? 0 : Convert.ToInt32(txtCoPIProjects.Text.Trim());
                        cmd.Parameters.Add("@TotalFundedProjects", SqlDbType.Int).Value = piProjects + coPiProjects;

                        cmd.ExecuteNonQuery();
                    }
                }

                // Recalculate and save research score
                int researchScore = CalculateResearchScore();
                SaveResearchScore(userID, researchScore);

                // UPDATE EXPERIENCE SCORE
                UpdateExperienceScore(userID);
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

                lblMessage.Text = "Publication added successfully! Research score updated.";
                lblMessage.CssClass = "ms-3 text-success";
                ClearPublicationFields();
                LoadPublications();
                LoadResearchScore();
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
                    int userID = Convert.ToInt32(Session["UserID"]);

                    string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
                    string query = @"DELETE FROM Publications WHERE id = @id AND user_id = @userID";

                    using (SqlConnection con = new SqlConnection(cs))
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = publicationId;
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    // Update counts after deletion
                    UpdatePublicationCounts(userID);

                    // Recalculate and save research score
                    int researchScore = CalculateResearchScore();
                    SaveResearchScore(userID, researchScore);

                    // UPDATE EXPERIENCE SCORE
                    UpdateExperienceScore(userID);

                    LoadPublications();
                    LoadResearchScore();
                    lblMessage.Text = "Publication deleted successfully. Research score updated.";
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
                int userID = Convert.ToInt32(Session["UserID"]);
                SaveResearchProfile();

                // Recalculate and save research score
                int researchScore = CalculateResearchScore();
                SaveResearchScore(userID, researchScore);

                // UPDATE EXPERIENCE SCORE
                UpdateExperienceScore(userID);

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