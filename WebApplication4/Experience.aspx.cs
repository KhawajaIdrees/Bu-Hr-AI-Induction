using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication4
{
    public partial class ExperiencePhd : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadExperiences();
                LoadExperienceScores();
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            int userId = Convert.ToInt32(Session["UserID"]);

            string organization = txtOrganization.Text.Trim();
            string position = txtPosition.Text.Trim();

            DateTime startDate;
            if (!DateTime.TryParse(txtStartDate.Text, out startDate))
            {
                lblMessage.Text = "Please enter a valid Start Date.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            DateTime? endDate = null;
            if (!chkCurrentJob.Checked && !string.IsNullOrWhiteSpace(txtEndDate.Text))
            {
                DateTime endDateTemp;
                if (DateTime.TryParse(txtEndDate.Text, out endDateTemp))
                {
                    endDate = endDateTemp;
                }
                else
                {
                    lblMessage.Text = "Please enter a valid End Date.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }

            bool currentJob = chkCurrentJob.Checked;

            SaveExperience(userId,
                           organization,
                           position,
                           startDate,
                           endDate,
                           currentJob);

            ClearForm();
            LoadExperiences();
            CalculateAndSaveExperienceScore(userId);

            lblMessage.Text = "Experience added successfully.";
            lblMessage.CssClass = "text-success";
        }

        private void SaveExperience(int userId,
                                    string organization,
                                    string position,
                                    DateTime startDate,
                                    DateTime? endDate,
                                    bool currentJob)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // IsRelevant defaults to 1 in DB — the AI updates it later
                string query = @"INSERT INTO WorkExperience
                                (UserId,
                                 OrganizationName,
                                 PositionTitle,
                                 StartDate,
                                 EndDate,
                                 IsCurrentJob)
                                VALUES
                                (@UserId,
                                 @OrganizationName,
                                 @PositionTitle,
                                 @StartDate,
                                 @EndDate,
                                 @IsCurrentJob)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@OrganizationName", organization);
                cmd.Parameters.AddWithValue("@PositionTitle", position);
                cmd.Parameters.AddWithValue("@StartDate", startDate);

                if (endDate.HasValue)
                    cmd.Parameters.AddWithValue("@EndDate", endDate.Value);
                else
                    cmd.Parameters.AddWithValue("@EndDate", DBNull.Value);

                cmd.Parameters.AddWithValue("@IsCurrentJob", currentJob);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void LoadExperiences()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        ExperienceId,
                        OrganizationName,
                        PositionTitle,
                        StartDate,
                        CASE
                            WHEN IsCurrentJob = 1 THEN NULL
                            ELSE EndDate
                        END AS EndDate,
                        CONCAT(
                            DATEDIFF(MONTH,
                                     StartDate,
                                     ISNULL(EndDate, GETDATE())) / 12,
                            ' Years ',
                            DATEDIFF(MONTH,
                                     StartDate,
                                     ISNULL(EndDate, GETDATE())) % 12,
                            ' Months'
                        ) AS Duration
                    FROM WorkExperience
                    WHERE UserId=@UserId
                    ORDER BY StartDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserId", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvExperiences.DataSource = dt;
                gvExperiences.DataBind();
            }
        }

        private void LoadExperienceScores()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        ExperienceScore,
                        ExperienceLevel,
                        ResearchScore,
                        TotalExperienceScore
                    FROM ExperienceScores
                    WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int expScore = reader["ExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["ExperienceScore"]) : 0;
                        string expLevel = reader["ExperienceLevel"] != DBNull.Value ? reader["ExperienceLevel"].ToString() : "None";
                        int researchScore = reader["ResearchScore"] != DBNull.Value ? Convert.ToInt32(reader["ResearchScore"]) : 0;
                        int totalExpScore = reader["TotalExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["TotalExperienceScore"]) : 0;

                        ViewState["ExperienceScore"] = expScore;
                        ViewState["ExperienceLevel"] = expLevel;
                        ViewState["ResearchScore"] = researchScore;
                        ViewState["TotalExperienceScore"] = totalExpScore;
                    }
                }
            }
        }

        // =============================================
        // NEW RUBRIC: Experience max 15
        //    Total experience   = max 6
        //    Relevant (IsRelevant) = max 4
        //    Post-PhD           = max 3
        //    Supervision        = max 2
        // =============================================
        private void CalculateAndSaveExperienceScore(int userId)
        {
            int totalYears = GetTotalExperienceYears(userId);
            int relevantYears = GetRelevantExperienceYears(userId);
            int postPhdYears = GetPostPhDExperienceYears(userId);
            int supervisionPoints = GetSupervisionPoints(userId);

            int totalPoints = ScoreTotalYears(totalYears);          // 0..6
            int relevantPoints = ScoreRelevantYears(relevantYears);    // 0..4
            int postPhdPoints = ScorePostPhdYears(postPhdYears);      // 0..3

            // Supervision already capped at 2 inside GetSupervisionPoints

            int experienceScore = totalPoints + relevantPoints + postPhdPoints + supervisionPoints;
            if (experienceScore > 15) experienceScore = 15;

            string experienceLevel = GetExperienceLevel(totalYears);

            // Keep legacy column "ResearchScore" in sync with supervision points
            SaveExperienceScores(
                userId,
                experienceScore,
                experienceLevel,
                supervisionPoints,
                experienceScore,
                totalPoints,
                relevantPoints,
                postPhdPoints,
                supervisionPoints
            );
        }

        // ---- Total years across all experience ----
        private int GetTotalExperienceYears(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        ISNULL(SUM(
                            DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE()))
                        ), 0) AS TotalYears
                    FROM WorkExperience
                    WHERE UserId = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();

                object result = cmd.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToInt32(result) : 0;
            }
        }

        // ---- Years where IsRelevant = 1 ----
        private int GetRelevantExperienceYears(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        ISNULL(SUM(
                            DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE()))
                        ), 0) AS RelevantYears
                    FROM WorkExperience
                    WHERE UserId = @UserId AND ISNULL(IsRelevant, 1) = 1";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();

                object result = cmd.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToInt32(result) : 0;
            }
        }

        // ---- Post-PhD years ----
        private int GetPostPhDExperienceYears(int userId)
        {
            int phdYear = 0;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ISNULL(PhD_Year, 0) FROM Education WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    phdYear = Convert.ToInt32(result);
                }
            }

            if (phdYear == 0) return 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        ISNULL(SUM(
                            CASE 
                                WHEN YEAR(StartDate) >= @PhdYear THEN 
                                    DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE()))
                                ELSE 
                                    DATEDIFF(YEAR, @PhdYear, ISNULL(EndDate, GETDATE()))
                            END
                        ), 0) AS PostPhdYears
                    FROM WorkExperience
                    WHERE UserId = @UserId
                    AND YEAR(ISNULL(EndDate, GETDATE())) >= @PhdYear";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@PhdYear", phdYear);
                con.Open();

                object result = cmd.ExecuteScalar();
                return result != DBNull.Value ? Convert.ToInt32(result) : 0;
            }
        }

        // ---- Supervision points (max 2) ----
        private int GetSupervisionPoints(int userId)
        {
            int msStudents = 0;
            int phdStudents = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT ISNULL(MS_MPhil_Students, 0), ISNULL(PhDStudents, 0) FROM ResearchProfile WHERE user_id = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
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

            int points = (msStudents * 1) + (phdStudents * 2);
            if (points > 2) points = 2;
            return points;
        }

        // ---- Score mappings ----
        private int ScoreTotalYears(int years)
        {
            if (years >= 18) return 6;
            if (years >= 15) return 5;
            if (years >= 10) return 4;
            if (years >= 5) return 3;
            if (years >= 2) return 2;
            if (years >= 1) return 1;
            return 0;
        }

        private int ScoreRelevantYears(int years)
        {
            if (years >= 10) return 4;
            if (years >= 5) return 3;
            if (years >= 2) return 2;
            if (years >= 1) return 1;
            return 0;
        }

        private int ScorePostPhdYears(int years)
        {
            if (years >= 10) return 3;
            if (years >= 5) return 2;
            if (years >= 1) return 1;
            return 0;
        }

        // ---- Experience level text (label only) ----
        private string GetExperienceLevel(int totalYears)
        {
            if (totalYears >= 18) return "Professor";
            if (totalYears >= 15) return "Associate Professor";
            if (totalYears >= 10) return "Assistant Professor";
            if (totalYears >= 5) return "Lecturer";
            return "No Experience";
        }

        private void SaveExperienceScores(
            int userId,
            int experienceScore,
            string experienceLevel,
            int researchScore,       // legacy column = supervision points
            int totalExperienceScore,
            int totalPoints,
            int relevantPoints,
            int postPhdPoints,
            int supervisionPoints)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    IF EXISTS (SELECT 1 FROM ExperienceScores WHERE UserID = @UserID)
                    BEGIN
                        UPDATE ExperienceScores
                        SET 
                            ExperienceScore          = @ExperienceScore,
                            ExperienceLevel          = @ExperienceLevel,
                            ResearchScore            = @ResearchScore,
                            TotalExperienceScore     = @TotalExperienceScore,
                            TotalExperiencePoints    = @TotalExperiencePoints,
                            RelevantExperiencePoints = @RelevantExperiencePoints,
                            PostPhDExperiencePoints  = @PostPhDExperiencePoints,
                            SupervisionPoints        = @SupervisionPoints,
                            UpdatedAt                = GETDATE()
                        WHERE UserID = @UserID
                    END
                    ELSE
                    BEGIN
                        INSERT INTO ExperienceScores
                            (UserID, ExperienceScore, ExperienceLevel, ResearchScore, TotalExperienceScore,
                             TotalExperiencePoints, RelevantExperiencePoints, PostPhDExperiencePoints, SupervisionPoints)
                        VALUES
                            (@UserID, @ExperienceScore, @ExperienceLevel, @ResearchScore, @TotalExperienceScore,
                             @TotalExperiencePoints, @RelevantExperiencePoints, @PostPhDExperiencePoints, @SupervisionPoints)
                    END";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@ExperienceScore", experienceScore);
                cmd.Parameters.AddWithValue("@ExperienceLevel", experienceLevel);
                cmd.Parameters.AddWithValue("@ResearchScore", researchScore);
                cmd.Parameters.AddWithValue("@TotalExperienceScore", totalExperienceScore);
                cmd.Parameters.AddWithValue("@TotalExperiencePoints", totalPoints);
                cmd.Parameters.AddWithValue("@RelevantExperiencePoints", relevantPoints);
                cmd.Parameters.AddWithValue("@PostPhDExperiencePoints", postPhdPoints);
                cmd.Parameters.AddWithValue("@SupervisionPoints", supervisionPoints);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvExperiences_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteExperience")
            {
                int rowIndex;
                if (int.TryParse(e.CommandArgument.ToString(), out rowIndex))
                {
                    if (rowIndex >= 0 && rowIndex < gvExperiences.Rows.Count)
                    {
                        object key = gvExperiences.DataKeys[rowIndex]?.Value;
                        if (key != null)
                        {
                            int experienceId = Convert.ToInt32(key);
                            DeleteExperience(experienceId);
                            int userId = Convert.ToInt32(Session["UserID"]);
                            CalculateAndSaveExperienceScore(userId);
                            LoadExperiences();
                            LoadExperienceScores();
                            lblMessage.Text = "Experience deleted successfully.";
                            lblMessage.CssClass = "text-success";
                            return;
                        }
                    }
                }
                lblMessage.Text = "Unable to delete experience.";
                lblMessage.CssClass = "text-danger";
            }
        }

        private void DeleteExperience(int experienceId)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"DELETE FROM WorkExperience 
                                WHERE ExperienceId = @ExperienceId 
                                AND UserId = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ExperienceId", experienceId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void ClearForm()
        {
            txtOrganization.Text = "";
            txtPosition.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            chkCurrentJob.Checked = false;
        }

        protected void BtnNext_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            int count = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM WorkExperience WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                count = (int)cmd.ExecuteScalar();
            }

            if (count == 0)
            {
                lblMessage.Text = "Please add at least one work experience before continuing.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            CalculateAndSaveExperienceScore(userId);

            Response.Redirect("ResearchData.aspx");
        }
    }
}