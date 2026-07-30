using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Data.Entity.Infrastructure.Design.Executor;



namespace WebApplication4
{
    public partial class candDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    lblMessage.Text = "User session not found.";
                    return;
                }

                int userID = Convert.ToInt32(Session["UserID"]); 
               // LoadCandidateDegrees(userID);
            }
        }
        private void LoadCandidateDegrees(int userID)
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
                              /*  ssc_subject.Value = reader["subject"].ToString();
                                ssc_board.Value = reader["board"].ToString();
                                ssc_year.Value = reader["year"].ToString();
                                ssc_result.Value = reader["result"].ToString();
                                ssc_grade.Value = reader["grade"].ToString();*/
                                break;

                            case "HSSC":
                            case "INTERMEDIATE":
                               /* hssc_subject.Value = reader["subject"].ToString();
                                hssc_board.Value = reader["board"].ToString();
                                hssc_year.Value = reader["year"].ToString();
                                hssc_result.Value = reader["result"].ToString();
                                hssc_grade.Value = reader["grade"].ToString();*/
                                break;

                               
                                    case "BS":
                                    case "BS(HONS)":
                                    case "BS (HONS)":
                                    case "BSC":
                                    case "B.SC":
                                    case "BACHELOR":
                                     /*   bs_subject.Value = reader["subject"].ToString();
                                        bs_board.Value = reader["board"].ToString();
                                        bs_year.Value = reader["year"].ToString();
                                        bs_result.Value = reader["result"].ToString();
                                        bs_grade.Value = reader["grade"].ToString();*/
                                        break;
                               
                            case "MS":
                            case "MPHIL":
                            case "MS/MPHIL":
                             /*   ms_subject.Value = reader["subject"].ToString();
                                ms_board.Value = reader["board"].ToString();
                                ms_year.Value = reader["year"].ToString();
                                ms_result.Value = reader["result"].ToString();
                                ms_grade.Value = reader["grade"].ToString();*/
                                break;

                            case "PHD":
                              /*  phd_subject.Value = reader["subject"].ToString();
                                phd_board.Value = reader["board"].ToString();
                                phd_year.Value = reader["year"].ToString();
                                phd_result.Value = reader["result"].ToString();
                                phd_grade.Value = reader["grade"].ToString();*/
                                break;
                        } //switch

                    } //while

                } //reader

            }
    }
              
    
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            int userID;
            userID = Convert.ToInt32(Session["UserID"]);
            string sscDuration = ssc_duration.Value;
            string sscSpecialization = ssc_specialization.Value;
            int.TryParse(ssc_year.Value, out int sscYear);
            decimal.TryParse(sscper.Value, out decimal sscPer);
            string sscUniversity = ssc_uni.Value;
            string sscCountry = ssc_country.Value;

            //=========================
            // HSSC
            //=========================
            string hsscDuration = hssc_duration.Value;
            string hsscSpecialization = hssc_specialization.Value;
            int.TryParse(hssc_year.Value, out int hsscYear);
            decimal.TryParse(hsscper.Value, out decimal hsscPer);
            string hsscUniversity = hssc_uni.Value;
            string hsscCountry = hssc_country.Value;

            //=========================
            // Bachelor
            //=========================
            string bsDuration = bs_duration.Value;
            string bsSpecialization = bs_specialization.Value;
            int.TryParse(bs_year.Value, out int bsYear);
            decimal.TryParse(bs_cgpa.Value, out decimal bsCgpa);
            string bsUniversity = bs_uni.Value;
            string bsCountry = bs_country.Value;

            //=========================
            // Masters
            //=========================
            string msDuration = ms_duration.Value;
            string msSpecialization = ms_specialization.Value;
            int.TryParse(ms_year.Value, out int msYear);
            decimal.TryParse(ms_cgpa.Value, out decimal msCgpa);
            string msUniversity = ms_uni.Value;
            string msCountry = ms_country.Value;

            //=========================
            // PhD
            //=========================
            string phdDuration = phd_duration.Value;
            string phdSpecialization = phd_specialization.Value;
            int.TryParse(phd_year.Value, out int phdYear);
            decimal.TryParse(phd_cgpa.Value, out decimal phdCgpa);
            string phdUniversity = phd_uni.Value;
            string phdCountry = phd_country.Value;

            //=========================
            // Post Doctorate
            //=========================
            string postdocDuration = postdoc_duration.Value;
            string postdocSpecialization = postdoc_specialization.Value;
            int.TryParse(postdoc_year.Value, out int postdocYear);
            decimal.TryParse(postdoc_cgpa.Value, out decimal postdocCgpa);
            string postdocUniversity = postdoc_uni.Value;
            string postdocCountry = postdoc_country.Value;


           

            if (!(SecondDivision(sscPer))&& (!(SecondDivision(hsscPer))))
                    {
                SaveEducationalInformation(
    userID,

    // SSC
    sscDuration, sscSpecialization, sscYear, sscPer, sscUniversity, sscCountry,

    // HSSC
    hsscDuration, hsscSpecialization, hsscYear, hsscPer, hsscUniversity, hsscCountry,

    // Bachelor
    bsDuration, bsSpecialization, bsYear, bsCgpa, bsUniversity, bsCountry,

    // Masters
    msDuration, msSpecialization, msYear, msCgpa, msUniversity, msCountry,

    // PhD
    phdDuration, phdSpecialization, phdYear, phdCgpa, phdUniversity, phdCountry,

    // Post Doctorate
    postdocDuration, postdocSpecialization, postdocYear, postdocCgpa, postdocUniversity, postdocCountry
);
        

               Response.Redirect("Experience.aspx");

                } 

            }


        protected void SaveEducationalInformation(
    int userId,

    string sscDuration, string sscSpecialization, int sscYear, decimal sscCgpa, string sscUniversity, string sscCountry,

    string hsscDuration, string hsscSpecialization, int hsscYear, decimal hsscCgpa, string hsscUniversity, string hsscCountry,

    string bsDuration, string bsSpecialization, int bsYear, decimal bsCgpa, string bsUniversity, string bsCountry,

    string msDuration, string msSpecialization, int? msYear, decimal? msCgpa, string msUniversity, string msCountry,

    string phdDuration, string phdSpecialization, int? phdYear, decimal? phdCgpa, string phdUniversity, string phdCountry,

    string postdocDuration, string postdocSpecialization, int? postdocYear, decimal? postdocCgpa, string postdocUniversity, string postdocCountry)
        {
            string cs = @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=HR;Integrated Security=True";

            string query = @"
IF EXISTS (SELECT 1 FROM Education WHERE UserID=@UserID)
BEGIN
    UPDATE Education
    SET
        SSC_Duration=@SSC_Duration,
        SSC_Specialization=@SSC_Specialization,
        SSC_Year=@SSC_Year,
        SSC_CGPA=@SSC_CGPA,
        SSC_University=@SSC_University,
        SSC_Country=@SSC_Country,

        HSSC_Duration=@HSSC_Duration,
        HSSC_Specialization=@HSSC_Specialization,
        HSSC_Year=@HSSC_Year,
        HSSC_CGPA=@HSSC_CGPA,
        HSSC_University=@HSSC_University,
        HSSC_Country=@HSSC_Country,

        BS_Duration=@BS_Duration,
        BS_Specialization=@BS_Specialization,
        BS_Year=@BS_Year,
        BS_CGPA=@BS_CGPA,
        BS_University=@BS_University,
        BS_Country=@BS_Country,

        MS_Duration=@MS_Duration,
        MS_Specialization=@MS_Specialization,
        MS_Year=@MS_Year,
        MS_CGPA=@MS_CGPA,
        MS_University=@MS_University,
        MS_Country=@MS_Country,

        PhD_Duration=@PhD_Duration,
        PhD_Specialization=@PhD_Specialization,
        PhD_Year=@PhD_Year,
        PhD_CGPA=@PhD_CGPA,
        PhD_University=@PhD_University,
        PhD_Country=@PhD_Country,

        PostDoc_Duration=@PostDoc_Duration,
        PostDoc_Specialization=@PostDoc_Specialization,
        PostDoc_Year=@PostDoc_Year,
        PostDoc_CGPA=@PostDoc_CGPA,
        PostDoc_University=@PostDoc_University,
        PostDoc_Country=@PostDoc_Country

    WHERE UserID=@UserID;
END
ELSE
BEGIN
    INSERT INTO Education
    (
        UserID,

        SSC_Duration,SSC_Specialization,SSC_Year,SSC_CGPA,SSC_University,SSC_Country,
        HSSC_Duration,HSSC_Specialization,HSSC_Year,HSSC_CGPA,HSSC_University,HSSC_Country,
        BS_Duration,BS_Specialization,BS_Year,BS_CGPA,BS_University,BS_Country,
        MS_Duration,MS_Specialization,MS_Year,MS_CGPA,MS_University,MS_Country,
        PhD_Duration,PhD_Specialization,PhD_Year,PhD_CGPA,PhD_University,PhD_Country,
        PostDoc_Duration,PostDoc_Specialization,PostDoc_Year,PostDoc_CGPA,PostDoc_University,PostDoc_Country
    )
    VALUES
    (
        @UserID,

        @SSC_Duration,@SSC_Specialization,@SSC_Year,@SSC_CGPA,@SSC_University,@SSC_Country,
        @HSSC_Duration,@HSSC_Specialization,@HSSC_Year,@HSSC_CGPA,@HSSC_University,@HSSC_Country,
        @BS_Duration,@BS_Specialization,@BS_Year,@BS_CGPA,@BS_University,@BS_Country,
        @MS_Duration,@MS_Specialization,@MS_Year,@MS_CGPA,@MS_University,@MS_Country,
        @PhD_Duration,@PhD_Specialization,@PhD_Year,@PhD_CGPA,@PhD_University,@PhD_Country,
        @PostDoc_Duration,@PostDoc_Specialization,@PostDoc_Year,@PostDoc_CGPA,@PostDoc_University,@PostDoc_Country
    );
END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);

                cmd.Parameters.AddWithValue("@SSC_Duration", sscDuration);
                cmd.Parameters.AddWithValue("@SSC_Specialization", sscSpecialization);
                cmd.Parameters.AddWithValue("@SSC_Year", sscYear);
                cmd.Parameters.AddWithValue("@SSC_CGPA", sscCgpa);
                cmd.Parameters.AddWithValue("@SSC_University", sscUniversity);
                cmd.Parameters.AddWithValue("@SSC_Country", sscCountry);

                cmd.Parameters.AddWithValue("@HSSC_Duration", hsscDuration);
                cmd.Parameters.AddWithValue("@HSSC_Specialization", hsscSpecialization);
                cmd.Parameters.AddWithValue("@HSSC_Year", hsscYear);
                cmd.Parameters.AddWithValue("@HSSC_CGPA", hsscCgpa);
                cmd.Parameters.AddWithValue("@HSSC_University", hsscUniversity);
                cmd.Parameters.AddWithValue("@HSSC_Country", hsscCountry);

                cmd.Parameters.AddWithValue("@BS_Duration", bsDuration);
                cmd.Parameters.AddWithValue("@BS_Specialization", bsSpecialization);
                cmd.Parameters.AddWithValue("@BS_Year", bsYear);
                cmd.Parameters.AddWithValue("@BS_CGPA", bsCgpa);
                cmd.Parameters.AddWithValue("@BS_University", bsUniversity);
                cmd.Parameters.AddWithValue("@BS_Country", bsCountry);

                cmd.Parameters.AddWithValue("@MS_Duration", (object)msDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Specialization", (object)msSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Year", (object)msYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_CGPA", (object)msCgpa ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_University", (object)msUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Country", (object)msCountry ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@PhD_Duration", (object)phdDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Specialization", (object)phdSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Year", (object)phdYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_CGPA", (object)phdCgpa ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_University", (object)phdUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Country", (object)phdCountry ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@PostDoc_Duration", (object)postdocDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Specialization", (object)postdocSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Year", (object)postdocYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_CGPA", (object)postdocCgpa ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_University", (object)postdocUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Country", (object)postdocCountry ?? DBNull.Value);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        
        protected bool SecondDivision(decimal result)
        {
            if (result >= 60)
                return false;
            else
            {
                lblMessage.Text = "Second Division in Education cannot apply!";
                lblMessage.ForeColor = System.Drawing.Color.Red; return true;
            }
        }

        
    }
}
        
    
    