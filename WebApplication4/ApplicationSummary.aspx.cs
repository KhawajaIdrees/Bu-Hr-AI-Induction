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
            }
        }

        // ============================================
        // FILL PERSONAL INFORMATION (from Personal table)
        // ============================================
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

                    // Set gender radio button
                    string gender = reader["gender"].ToString();
                    if (gender.ToLower() == "male")
                        rbMale.Checked = true;
                    else if (gender.ToLower() == "female")
                        rbFemale.Checked = true;

                    reader.Close();
                }
                else
                {
                    txtName.Text = "No personal information found.";
                }
            }
        }

        // ============================================
        // FILL EDUCATION INFORMATION (from Education table)
        // ============================================
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
                        // SSC - Using new column names
                        ssc_subject.Value = reader["SSC_Specialization"].ToString();
                        ssc_board.Value = reader["SSC_University"].ToString();
                        ssc_year.Value = reader["SSC_Year"].ToString();
                        ssc_result.Value = reader["SSC_Percentage"].ToString();
                        ssc_grade.Value = reader["SSC_Percentage"].ToString();

                        // HSSC - Using new column names
                        hssc_subject.Value = reader["HSSC_Specialization"].ToString();
                        hssc_board.Value = reader["HSSC_University"].ToString();
                        hssc_year.Value = reader["HSSC_Year"].ToString();
                        hssc_result.Value = reader["HSSC_Percentage"].ToString();
                        hssc_grade.Value = reader["HSSC_Percentage"].ToString();

                        // BS - Using new column names
                        bs_subject.Value = reader["BS_Specialization"].ToString();
                        bs_board.Value = reader["BS_University"].ToString();
                        bs_year.Value = reader["BS_Year"].ToString();
                        bs_result.Value = reader["BS_Percentage"].ToString();
                        bs_grade.Value = reader["BS_Percentage"].ToString();

                        // MS (if exists) - Using new column names
                        if (reader["MS_Specialization"] != DBNull.Value)
                        {
                            ms_subject.Value = reader["MS_Specialization"].ToString();
                            ms_board.Value = reader["MS_University"].ToString();
                            ms_year.Value = reader["MS_Year"].ToString();
                            ms_result.Value = reader["MS_Percentage"].ToString();
                            ms_grade.Value = reader["MS_Percentage"].ToString();
                        }

                        // PhD (if exists) - Using new column names
                        if (reader["PhD_Specialization"] != DBNull.Value)
                        {
                            phd_subject.Value = reader["PhD_Specialization"].ToString();
                            phd_board.Value = reader["PhD_University"].ToString();
                            phd_year.Value = reader["PhD_Year"].ToString();
                            phd_result.Value = reader["PhD_Percentage"].ToString();
                            phd_grade.Value = reader["PhD_Percentage"].ToString();
                        }
                    }
                    else
                    {
                        ssc_subject.Value = "No education found";
                    }
                }
            }
        }

        // ============================================
        // FILL WORK EXPERIENCE (FULLY FIXED)
        // ============================================
        protected void FillWorkExperience(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT 
                                OrganizationName,
                                PositionTitle,
                                StartDate,
                                EndDate,
                                IsCurrentJob,
                                DATEDIFF(YEAR, StartDate, ISNULL(EndDate, GETDATE())) AS TotalYears
                            FROM WorkExperience
                            WHERE UserId = @UserID
                            ORDER BY StartDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            {
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

                                // FIXED: Check for NULL StartDate
                                string start;
                                if (reader["StartDate"] == DBNull.Value)
                                {
                                    start = "N/A";
                                }
                                else
                                {
                                    start = Convert.ToDateTime(reader["StartDate"]).ToString("MMM yyyy");
                                }

                                // FIXED: Check for NULL EndDate
                                string end;
                                if (reader["IsCurrentJob"].ToString() == "True")
                                {
                                    end = "Present";
                                }
                                else if (reader["EndDate"] == DBNull.Value)
                                {
                                    end = "Present";
                                }
                                else
                                {
                                    end = Convert.ToDateTime(reader["EndDate"]).ToString("MMM yyyy");
                                }

                                int years = 0;
                                if (reader["TotalYears"] != DBNull.Value)
                                {
                                    years = Convert.ToInt32(reader["TotalYears"]);
                                }
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
        }

        // ============================================
        // FILL RESEARCH PROFILE (from ResearchProfile table)
        // ============================================
        protected void FillResearchProfile(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT * FROM ResearchProfile WHERE user_id = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtHIndex.Text = reader["WCount"].ToString();
                            txtMSStudents.Text = reader["MSStudents"].ToString();
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
        }

        // ============================================
        // BUTTON CLICK EVENTS
        // ============================================
        protected void BtnPersonalInfo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Personal.aspx");
        }

        protected void BtnApplicationInfo_Click(object sender, EventArgs e)
        {
            // You can add logic here if needed
        }

        protected void BtnEducationalInfo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Education.aspx");
        }

        protected void BtnExperienceInfo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Experience.aspx");
        }
    }
}