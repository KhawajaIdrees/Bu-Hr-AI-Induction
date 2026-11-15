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
                // Sync W/X/Y counts from Publications every time the page loads
                int userID = Convert.ToInt32(Session["UserID"]);
                UpdatePublicationCounts(userID);

                LoadResearchProfile();
                LoadPublications();
                LoadResearchScore();
            }
        }

        protected void LoadResearchProfile()
        {
            if (Session["UserID"] == null) return;
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
                        try { txtTotalPublications.Text = dr["TotalPublications"].ToString(); } catch { txtTotalPublications.Text = "0"; }
                        try { txtHECPublications.Text = dr["HECPublications"].ToString(); } catch { txtHECPublications.Text = "0"; }
                        try { txtMSMPhilStudents.Text = dr["MS_MPhil_Students"].ToString(); } catch { txtMSMPhilStudents.Text = "0"; }
                        try { txtPhDStudents.Text = dr["PhDStudents"].ToString(); } catch { txtPhDStudents.Text = "0"; }
                        try { txtPIProjects.Text = dr["PIProjects"].ToString(); } catch { txtPIProjects.Text = "0"; }
                        try { txtCoPIProjects.Text = dr["CoPIProjects"].ToString(); } catch { txtCoPIProjects.Text = "0"; }
                        try { txtConsultancyAmount.Text = dr["ConsultancyAmount"].ToString(); } catch { txtConsultancyAmount.Text = ""; }
                    }
                    else
                    {
                        ClearResearchFields();
                    }
                }
            }
        }

        protected void LoadPublications()
        {
            if (Session["UserID"] == null) return;
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT 
                                id as PublicationID,
                                PublicationType, Category, Status, AuthorType,
                                ArticleTitle, Authors, JournalName,
                                PublicationDate, PublicationYear, DOI
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
                        lblMessage.Text = "⚠ Fill the form above and click 'Add Publication' to save it.";
                        lblMessage.CssClass = "ms-3 text-warning";
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
                ViewState["ResearchScore"] = (result != null && result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }
        }

        private int CalculateResearchScore()
        {
            int wCount = 0, xCount = 0, yCount = 0, fundedProjects = 0;
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT 
                                ISNULL(WCount, 0) AS WCount, 
                                ISNULL(XCount, 0) AS XCount, 
                                ISNULL(YCount, 0) AS YCount,
                                ISNULL(TotalFundedProjects, 0) AS TotalFundedProjects
                            FROM ResearchProfile WHERE user_id = @userID";

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
                        fundedProjects = reader["TotalFundedProjects"] != DBNull.Value ? Convert.ToInt32(reader["TotalFundedProjects"]) : 0;
                    }
                }
            }

            int researchScore = (wCount * 5) + (xCount * 3) + (yCount * 1) + (fundedProjects * 5);
            if (researchScore > 25) researchScore = 25;
            return researchScore;
        }

        private void SaveResearchScore(int userId, int researchScore)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"UPDATE ResearchProfile 
                             SET ResearchScore = @ResearchScore, UpdatedAt = GETDATE() 
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

        private void UpdatePublicationCounts(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            // Case-insensitive + trimmed count of W/X/Y
            string query = @"
                SELECT 
                    COUNT(CASE WHEN UPPER(LTRIM(RTRIM(Category))) = 'W' THEN 1 END) AS WCount,
                    COUNT(CASE WHEN UPPER(LTRIM(RTRIM(Category))) = 'X' THEN 1 END) AS XCount,
                    COUNT(CASE WHEN UPPER(LTRIM(RTRIM(Category))) = 'Y' THEN 1 END) AS YCount
                FROM Publications WHERE user_id = @userID";

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
                SET WCount = @WCount, XCount = @XCount, YCount = @YCount, UpdatedAt = GETDATE()
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

        private void UpdateExperienceScore(int userId)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            int totalYears = 0;
            int postPhdYears = 0;
            string position = "";
            int phdYear = 0;
            int msStudents = 0, phdStudents = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string q1 = @"SELECT ISNULL(SUM(DATEDIFF(MONTH, StartDate, ISNULL(EndDate, GETDATE())) / 12), 0)
                              FROM WorkExperience WHERE UserId = @UserId";
                using (SqlCommand cmd = new SqlCommand(q1, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    totalYears = Convert.ToInt32(cmd.ExecuteScalar());
                }

                string q2 = @"SELECT TOP 1 PositionTitle FROM WorkExperience 
                              WHERE UserId = @UserId ORDER BY StartDate DESC";
                using (SqlCommand cmd = new SqlCommand(q2, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    object r = cmd.ExecuteScalar();
                    position = (r == null || r == DBNull.Value) ? "" : r.ToString().Trim();
                }

                string q3 = "SELECT ISNULL(PhD_Year, 0) FROM Education WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(q3, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    object r = cmd.ExecuteScalar();
                    if (r != null && r != DBNull.Value) phdYear = Convert.ToInt32(r);
                }

                if (phdYear > 0)
                {
                    string q4 = @"SELECT ISNULL(SUM(CASE 
                                     WHEN YEAR(StartDate) >= @PhdYear THEN 
                                         DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE()))
                                     ELSE 
                                         DATEDIFF(YEAR, @PhdYear, ISNULL(EndDate, GETDATE()))
                                  END), 0)
                                  FROM WorkExperience
                                  WHERE UserId = @UserId AND YEAR(ISNULL(EndDate, GETDATE())) >= @PhdYear";
                    using (SqlCommand cmd = new SqlCommand(q4, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@PhdYear", phdYear);
                        postPhdYears = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                }

                string q5 = "SELECT ISNULL(MS_MPhil_Students, 0), ISNULL(PhDStudents, 0) FROM ResearchProfile WHERE user_id = @UserID";
                using (SqlCommand cmd = new SqlCommand(q5, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            msStudents = Convert.ToInt32(r[0]);
                            phdStudents = Convert.ToInt32(r[1]);
                        }
                    }
                }
            }

            string pos = position.ToLower();
            int experienceScore = 0;
            if (pos.Contains("assistant") && pos.Contains("professor"))
            {
                if (postPhdYears >= 5 || totalYears >= 10) experienceScore = 10;
            }
            else if (pos.Contains("associate") && pos.Contains("professor"))
            {
                if (postPhdYears >= 5 || totalYears >= 10) experienceScore = 15;
            }
            else if (pos.Contains("professor"))
            {
                if (postPhdYears >= 10 || totalYears >= 15) experienceScore = 20;
            }
            else if (pos.Contains("lecturer"))
            {
                if (totalYears >= 18) experienceScore = 5;
            }

            int researchSupervisionScore = (msStudents * 1) + (phdStudents * 2);
            int totalExperienceScore = experienceScore + researchSupervisionScore;
            if (totalExperienceScore > 25) totalExperienceScore = 25;

            string upsert = @"
                IF EXISTS (SELECT 1 FROM ExperienceScores WHERE UserID = @UserID)
                    UPDATE ExperienceScores 
                    SET ExperienceScore = @ExperienceScore,
                        ResearchScore = @ResearchScore,
                        TotalExperienceScore = @TotalExperienceScore,
                        UpdatedAt = GETDATE()
                    WHERE UserID = @UserID
                ELSE
                    INSERT INTO ExperienceScores (UserID, ExperienceScore, ResearchScore, TotalExperienceScore)
                    VALUES (@UserID, @ExperienceScore, @ResearchScore, @TotalExperienceScore)";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(upsert, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ExperienceScore", experienceScore);
                cmd.Parameters.AddWithValue("@ResearchScore", researchSupervisionScore);
                cmd.Parameters.AddWithValue("@TotalExperienceScore", totalExperienceScore);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void AddPublication()
        {
            if (Session["UserID"] == null) return;
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                INSERT INTO Publications
                (user_id, PublicationType, Category, Status, AuthorType, ArticleTitle,
                 Authors, JournalName, PublicationDate, PublicationYear, DOI)
                VALUES
                (@userId, @PublicationType, @Category, @Status, @AuthorType, @ArticleTitle,
                 @Authors, @JournalName, @PublicationDate, @PublicationYear, @DOI)";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userID;
                cmd.Parameters.Add("@PublicationType", SqlDbType.NVarChar).Value = ddlPublicationType.SelectedValue;
                cmd.Parameters.Add("@Category", SqlDbType.NVarChar).Value = ddlCategory.SelectedValue;
                cmd.Parameters.Add("@Status", SqlDbType.NVarChar).Value = ddlPublicationStatus.SelectedValue;
                cmd.Parameters.Add("@AuthorType", SqlDbType.NVarChar).Value = ddlAuthorType.SelectedValue;
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

            UpdatePublicationCounts(userID);
            int researchScore = CalculateResearchScore();
            SaveResearchScore(userID, researchScore);
            UpdateExperienceScore(userID);
        }

        protected void SaveResearchProfile()
        {
            if (Session["UserID"] == null) return;
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            try
            {
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
                        (user_id, TotalPublications, HECPublications, MS_MPhil_Students, PhDStudents,
                         PIProjects, CoPIProjects, ConsultancyAmount, TotalFundedProjects)
                        VALUES
                        (@userID, @TotalPublications, @HECPublications, @MSMPhilStudents, @PhDStudents,
                         @PIProjects, @CoPIProjects, @ConsultancyAmount, @TotalFundedProjects)";
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

                        int piProjects = string.IsNullOrWhiteSpace(txtPIProjects.Text) ? 0 : Convert.ToInt32(txtPIProjects.Text.Trim());
                        int coPiProjects = string.IsNullOrWhiteSpace(txtCoPIProjects.Text) ? 0 : Convert.ToInt32(txtCoPIProjects.Text.Trim());
                        cmd.Parameters.Add("@TotalFundedProjects", SqlDbType.Int).Value = piProjects + coPiProjects;

                        cmd.ExecuteNonQuery();
                    }
                }

                int researchScore = CalculateResearchScore();
                SaveResearchScore(userID, researchScore);
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
            if (string.IsNullOrEmpty(ddlAuthorType.SelectedValue))
            {
                lblMessage.Text = "Please select Author Type.";
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
            ddlAuthorType.SelectedIndex = 0;
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

                    UpdatePublicationCounts(userID);
                    int researchScore = CalculateResearchScore();
                    SaveResearchScore(userID, researchScore);
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

        // FIXED: Auto-saves any pending publication before navigating away.
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                int userID = Convert.ToInt32(Session["UserID"]);

                // 1. Save the Research Summary
                SaveResearchProfile();

                // 2. Auto-save the publication if the user filled the form
                //    but never clicked "Add Publication".
                bool hasPendingPublication =
                    !string.IsNullOrWhiteSpace(ddlPublicationType.SelectedValue) &&
                    !string.IsNullOrWhiteSpace(ddlCategory.SelectedValue) &&
                    !string.IsNullOrWhiteSpace(ddlPublicationStatus.SelectedValue) &&
                    !string.IsNullOrWhiteSpace(ddlAuthorType.SelectedValue) &&
                    !string.IsNullOrWhiteSpace(txtArticleTitle.Text) &&
                    !string.IsNullOrWhiteSpace(txtAuthors.Text) &&
                    !string.IsNullOrWhiteSpace(txtJournalName.Text) &&
                    !string.IsNullOrWhiteSpace(txtPublicationYear.Text);

                if (hasPendingPublication)
                {
                    AddPublication();
                    ClearPublicationFields();
                }

                // 3. Recalculate and save everything
                UpdatePublicationCounts(userID);
                int researchScore = CalculateResearchScore();
                SaveResearchScore(userID, researchScore);
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