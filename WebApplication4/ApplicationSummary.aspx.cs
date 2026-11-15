using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class ApplicationSummary : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                FillPersonal(userID);
                FillEducation(userID);
                FillWorkExperience(userID);
                FillResearchProfile(userID);
                FillProfileImage(userID);
                CheckIfAlreadySubmitted(userID);
            }
        }

        protected void CheckIfAlreadySubmitted(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = "SELECT IsSubmitted FROM Personal WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userID", userID);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null && Convert.ToBoolean(result) == true)
                {
                    btnSubmit.Enabled = false;
                    btnSubmit.Text = "✅ Already Submitted";
                    btnSubmit.CssClass = "submit-btn submitted";

                    ScriptManager.RegisterStartupScript(this, GetType(), "disableCheckbox",
                        "document.getElementById('agreeDeclaration').disabled = true;", true);

                    lblMessage.Text = "You have already submitted your application on " + GetSubmittedDate(userID);
                    lblMessage.CssClass = "text-success";
                }
                else
                {
                    btnSubmit.Enabled = false;
                }
            }
        }

        private string GetSubmittedDate(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = "SELECT SubmittedDate FROM Personal WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userID", userID);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    return Convert.ToDateTime(result).ToString("MM/dd/yyyy hh:mm tt");
                }
                return "unknown date";
            }
        }

        protected void FillProfileImage(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = "SELECT PhotoPath FROM Personal WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@userID", userID);
                con.Open();

                object result = cmd.ExecuteScalar();

                if (result != null && !string.IsNullOrEmpty(result.ToString()))
                    imgProfile.ImageUrl = result.ToString();
                else
                    imgProfile.ImageUrl = "~/Images/default-avatar.png";
            }
        }

        protected void FillPersonal(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = "SELECT * FROM Personal WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@userID", userID);
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["fname"].ToString() + " " + reader["lname"].ToString();
                    txtNationality.Text = reader["nationality"].ToString();
                    txtBirthDate.Text = Convert.ToDateTime(reader["birthdate"]).ToString("yyyy-MM-dd");
                    txtIdentity.Text = reader["cnic"].ToString();
                    txtCell.Text = reader["cellNumber"].ToString();

                    string gender = reader["gender"].ToString();
                    if (gender.ToLower() == "male") rbMale.Checked = true;
                    else if (gender.ToLower() == "female") rbFemale.Checked = true;

                    reader.Close();
                }
                else
                {
                    txtName.Text = "No personal information found.";
                }
            }
        }

        protected void FillEducation(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT * FROM Education WHERE UserID = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        ssc_subject.Value = reader["SSC_Specialization"].ToString();
                        ssc_board.Value = reader["SSC_University"].ToString();
                        ssc_year.Value = reader["SSC_Year"].ToString();
                        ssc_result.Value = FormatPercentage(reader["SSC_Percentage"]);

                        hssc_subject.Value = reader["HSSC_Specialization"].ToString();
                        hssc_board.Value = reader["HSSC_University"].ToString();
                        hssc_year.Value = reader["HSSC_Year"].ToString();
                        hssc_result.Value = FormatPercentage(reader["HSSC_Percentage"]);

                        bs_subject.Value = reader["BS_Specialization"].ToString();
                        bs_board.Value = reader["BS_University"].ToString();
                        bs_year.Value = reader["BS_Year"].ToString();
                        bs_result.Value = FormatPercentage(reader["BS_Percentage"]);

                        if (reader["MS_Specialization"] != DBNull.Value)
                        {
                            ms_subject.Value = reader["MS_Specialization"].ToString();
                            ms_board.Value = reader["MS_University"].ToString();
                            ms_year.Value = reader["MS_Year"].ToString();
                            ms_result.Value = FormatPercentage(reader["MS_Percentage"]);
                        }

                        if (reader["PhD_Specialization"] != DBNull.Value)
                        {
                            phd_subject.Value = reader["PhD_Specialization"].ToString();
                            phd_board.Value = reader["PhD_University"].ToString();
                            phd_year.Value = reader["PhD_Year"].ToString();
                            phd_result.Value = FormatPercentage(reader["PhD_Percentage"]);
                        }
                    }
                    else
                    {
                        ssc_subject.Value = "No education found";
                    }
                }
            }
        }

        private string FormatPercentage(object value)
        {
            if (value == null || value == DBNull.Value) return "";
            try
            {
                decimal percentage = Convert.ToDecimal(value);
                return Math.Round(percentage, 0).ToString();
            }
            catch { return value.ToString(); }
        }

        protected void FillWorkExperience(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT OrganizationName, PositionTitle, StartDate, EndDate, IsCurrentJob,
                                    DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) AS TotalYears
                             FROM WorkExperience
                             WHERE UserId = @UserID
                             ORDER BY StartDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        string experienceSummary = "";
                        int totalYears = 0;
                        int count = 0;

                        while (reader.Read())
                        {
                            count++;
                            string org = reader["OrganizationName"].ToString();
                            string pos = reader["PositionTitle"].ToString();

                            string start = reader["StartDate"] == DBNull.Value
                                ? "N/A" : Convert.ToDateTime(reader["StartDate"]).ToString("MMM yyyy");

                            string end;
                            if (reader["IsCurrentJob"].ToString() == "True" || reader["EndDate"] == DBNull.Value)
                                end = "Present";
                            else
                                end = Convert.ToDateTime(reader["EndDate"]).ToString("MMM yyyy");

                            int years = reader["TotalYears"] != DBNull.Value ? Convert.ToInt32(reader["TotalYears"]) : 0;
                            totalYears += years;

                            experienceSummary += $"{org} - {pos} ({start} to {end}) - {years} years\n";
                        }

                        txtExperienceBeforePhD.Text = $"Total: {totalYears} years across {count} position(s)";
                        txtExperienceBeforePhD.ToolTip = experienceSummary;
                    }
                    else
                    {
                        txtExperienceBeforePhD.Text = "No work experience found.";
                    }
                }
            }
        }

        protected void FillResearchProfile(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT * FROM ResearchProfile WHERE user_id = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtHIndex.Text = reader["WCount"].ToString();
                        txtMSStudents.Text = reader["MS_MPhil_Students"].ToString();
                        txtPhDStudents.Text = reader["PhDStudents"].ToString();
                        txtExperienceAfterPhD.Text = reader["TotalFundedProjects"].ToString();
                    }
                    else
                    {
                        txtHIndex.Text = "No research profile found.";
                    }
                }
            }
        }

        // ============================================================
        // SUBMIT — also writes a row into JobApplication if a job is pending
        // ============================================================
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            // Check if already submitted
            string checkQuery = "SELECT IsSubmitted FROM Personal WHERE userId = @userID";
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
            {
                checkCmd.Parameters.AddWithValue("@userID", userID);
                con.Open();

                object result = checkCmd.ExecuteScalar();
                if (result != null && Convert.ToBoolean(result) == true)
                {
                    lblMessage.Text = "You have already submitted this application.";
                    lblMessage.CssClass = "text-warning";
                    return;
                }
            }

            try
            {
                // 1. Mark Personal as submitted
                string query = @"UPDATE Personal 
                                 SET IsSubmitted = 1, SubmittedDate = GETDATE() 
                                 WHERE userId = @userID";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                // 2. If there's a pending job, write a JobApplication row
                if (Session["PendingJobId"] != null)
                {
                    int jobId = Convert.ToInt32(Session["PendingJobId"]);
                    InsertJobApplication(userID, jobId);
                }

                lblMessage.Text = "Application submitted successfully!";
                lblMessage.CssClass = "text-success";

                btnSubmit.Enabled = false;
                btnSubmit.Text = "Already Submitted";
                btnSubmit.CssClass = "submit-btn submitted";

                ScriptManager.RegisterStartupScript(this, GetType(), "disableCheckbox",
                    "document.getElementById('agreeDeclaration').disabled = true;", true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error submitting application: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }

        // Inserts a JobApplication row for the pending job.
        // Station comes from JobPostings.Campus.
        // JobCategory = HiringType for Teaching jobs (falls back to JobType).
        // CVPath comes from Personal.CVPath.
        private void InsertJobApplication(int userID, int jobId)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                IF NOT EXISTS (
                    SELECT 1 FROM JobApplication 
                    WHERE UserId = @UserId AND JobPostingID = @JobId
                )
                BEGIN
                    INSERT INTO JobApplication
                    (UserId, JobPostingID, Station, AdvertisementDate, JobType, JobCategory,
                     CVPath, Department, Specialization, Status)
                    SELECT 
                        @UserId,
                        p.JobPostingID,
                        p.Campus,
                        p.PublishedDate,
                        p.JobType,
                        ISNULL(NULLIF(p.HiringType, ''), p.JobType),
                        pers.CVPath,
                        p.Department,
                        p.Specialization,
                        'Pending'
                    FROM JobPostings p
                    CROSS JOIN Personal pers
                    WHERE p.JobPostingID = @JobId AND pers.userId = @UserId;
                END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userID);
                cmd.Parameters.AddWithValue("@JobId", jobId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void BtnPersonalInfo_Click(object sender, EventArgs e) { Response.Redirect("Personal.aspx"); }
        protected void BtnEducationalInfo_Click(object sender, EventArgs e) { Response.Redirect("Education.aspx"); }
        protected void BtnExperienceInfo_Click(object sender, EventArgs e) { Response.Redirect("Experience.aspx"); }
    }
}