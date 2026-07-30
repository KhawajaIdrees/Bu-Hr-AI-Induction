using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int userID = 0;

            if (Session["UserID"] != null)
            {
                userID = Convert.ToInt32(Session["UserID"]);
                lblMessage.Text = userID.ToString();
                FillPersonal(userID);
                FillEducation(userID);
                FillWork(userID);
            }

        }

        protected void FillPersonal(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = "SELECT * FROM Candidate WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@userID", userID);

                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtName.Text = reader["name"].ToString();
                    txtNationality.Text = reader["nationality"].ToString();
                    txtBirthDate.Text = reader["birthdate"].ToString();
                    txtIdentity.Text = reader["cnic"].ToString();
                    txtCell.Text = reader["cellNumber"].ToString();
                    rbMale.Text = reader["gender"].ToString();
                    reader.Close();
                }
                else
                {
                    lblMessage.Text = "User session not found.";
                }
            }
        }
        protected void FillEducation(int userID)
        {
            string query = @"SELECT type,
                            subject,
                            board,
                            year,
                            result,
                            grade
                     FROM Degree
                     WHERE userId = @UserID";
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;

                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string degreeType = reader["type"].ToString().Trim();

                        switch (degreeType.ToUpper())
                        {
                            case "SSC":
                            case "MATRIC":
                                ssc_subject.Value = reader["subject"].ToString();
                                ssc_board.Value = reader["board"].ToString();
                                ssc_year.Value = reader["year"].ToString();
                                ssc_result.Value = reader["result"].ToString();
                                ssc_grade.Value = reader["grade"].ToString();
                                break;

                            case "HSSC":
                            case "INTERMEDIATE":
                                hssc_subject.Value = reader["subject"].ToString();
                                hssc_board.Value = reader["board"].ToString();
                                hssc_year.Value = reader["year"].ToString();
                                hssc_result.Value = reader["result"].ToString();
                                hssc_grade.Value = reader["grade"].ToString();
                                break;


                            case "BS":
                            case "BS(HONS)":
                            case "BS (HONS)":
                            case "BSC":
                            case "B.SC":
                            case "BACHELOR":
                                bs_subject.Value = reader["subject"].ToString();
                                bs_board.Value = reader["board"].ToString();
                                bs_year.Value = reader["year"].ToString();
                                bs_result.Value = reader["result"].ToString();
                                bs_grade.Value = reader["grade"].ToString();
                                break;

                            case "MS":
                            case "MPHIL":
                            case "MS/MPHIL":
                                ms_subject.Value = reader["subject"].ToString();
                                ms_board.Value = reader["board"].ToString();
                                ms_year.Value = reader["year"].ToString();
                                ms_result.Value = reader["result"].ToString();
                                ms_grade.Value = reader["grade"].ToString();
                                break;

                            case "PHD":
                                phd_subject.Value = reader["subject"].ToString();
                                phd_board.Value = reader["board"].ToString();
                                phd_year.Value = reader["year"].ToString();
                                phd_result.Value = reader["result"].ToString();
                                phd_grade.Value = reader["grade"].ToString();
                                break;
                        } //switch

                    } //while

                } //reader
            }
        }
        protected void FillWork(int userID)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
            string query = @"SELECT HIndex,
                            ExperienceBeforePhD,
                            ExperienceAfterPhD,
                            supervisedMSStudents, 
                            supervisedPhDStudents
                     FROM Research
                     WHERE UserID = @UserID";

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
                            txtHIndex.Text = reader["HIndex"].ToString();

                            txtExperienceBeforePhD.Text =
                                reader["ExperienceBeforePhD"].ToString();

                            txtExperienceAfterPhD.Text =
                                reader["ExperienceAfterPhD"].ToString();

                            txtMSStudents.Text =
                                reader["supervisedMSStudents"].ToString();

                            txtPhDStudents.Text =
                                reader["supervisedPhDStudents"].ToString();
                        }
                        else
                        {
                            lblMessage.Text = "No record found.";
                        }
                    }
                }
            }


        }
        protected void BtnPersonalInfo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Personal.aspx");
        }

        protected void BtnApplicationInfo_Click(object sender, EventArgs e)
        {

        }

        protected void BtnEducationalInfo_Click(object sender, EventArgs e)
        { 
             Response.Redirect("EducationPhd.aspx");   
        }
        protected void BtnExperienceInfo_Click(object sender, EventArgs e)
        {
                Response.Redirect("ExperiencePhd.aspx");   
        }
    }
}