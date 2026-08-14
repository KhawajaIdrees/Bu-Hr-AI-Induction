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
                LoadEducationData(userID);
            }
        }

        private void LoadEducationData(int userID)
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
                        // SSC
                        ssc_duration.Value = reader["SSC_Duration"].ToString();
                        ssc_specialization.Value = reader["SSC_Specialization"].ToString();
                        ssc_year.Value = reader["SSC_Year"].ToString();
                        sscper.Value = reader["SSC_Percentage"].ToString();
                        ssc_uni.Value = reader["SSC_University"].ToString();
                        ssc_country.Value = reader["SSC_Country"].ToString();

                        // HSSC
                        hssc_duration.Value = reader["HSSC_Duration"].ToString();
                        hssc_specialization.Value = reader["HSSC_Specialization"].ToString();
                        hssc_year.Value = reader["HSSC_Year"].ToString();
                        hsscper.Value = reader["HSSC_Percentage"].ToString();
                        hssc_uni.Value = reader["HSSC_University"].ToString();
                        hssc_country.Value = reader["HSSC_Country"].ToString();

                        // BS
                        bs_type.Value = reader["BS_Type"].ToString();
                        bs_duration.Value = reader["BS_Duration"].ToString();
                        bs_specialization.Value = reader["BS_Specialization"].ToString();
                        bs_year.Value = reader["BS_Year"].ToString();
                        bs_cgpa.Value = reader["BS_Percentage"].ToString();
                        bs_uni.Value = reader["BS_University"].ToString();
                        bs_country.Value = reader["BS_Country"].ToString();

                        // MS (Optional)
                        if (reader["MS_Duration"] != DBNull.Value)
                        {
                            ms_duration.Value = reader["MS_Duration"].ToString();
                            ms_specialization.Value = reader["MS_Specialization"].ToString();
                            ms_year.Value = reader["MS_Year"].ToString();
                            ms_cgpa.Value = reader["MS_Percentage"].ToString();
                            ms_uni.Value = reader["MS_University"].ToString();
                            ms_country.Value = reader["MS_Country"].ToString();
                        }

                        // PhD (Optional)
                        if (reader["PhD_Duration"] != DBNull.Value)
                        {
                            phd_duration.Value = reader["PhD_Duration"].ToString();
                            phd_specialization.Value = reader["PhD_Specialization"].ToString();
                            phd_year.Value = reader["PhD_Year"].ToString();
                            phd_cgpa.Value = reader["PhD_Percentage"].ToString();
                            phd_uni.Value = reader["PhD_University"].ToString();
                            phd_country.Value = reader["PhD_Country"].ToString();
                        }

                        // PostDoc (Optional)
                        if (reader["PostDoc_Duration"] != DBNull.Value)
                        {
                            postdoc_duration.Value = reader["PostDoc_Duration"].ToString();
                            postdoc_specialization.Value = reader["PostDoc_Specialization"].ToString();
                            postdoc_year.Value = reader["PostDoc_Year"].ToString();
                            postdoc_cgpa.Value = reader["PostDoc_Percentage"].ToString();
                            postdoc_uni.Value = reader["PostDoc_University"].ToString();
                            postdoc_country.Value = reader["PostDoc_Country"].ToString();
                        }
                    }
                }
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            // SSC
            string sscDuration = ssc_duration.Value;
            string sscSpecialization = ssc_specialization.Value;
            int.TryParse(ssc_year.Value, out int sscYear);
            decimal.TryParse(sscper.Value, out decimal sscPer);
            string sscUniversity = ssc_uni.Value;
            string sscCountry = ssc_country.Value;

            // HSSC
            string hsscDuration = hssc_duration.Value;
            string hsscSpecialization = hssc_specialization.Value;
            int.TryParse(hssc_year.Value, out int hsscYear);
            decimal.TryParse(hsscper.Value, out decimal hsscPer);
            string hsscUniversity = hssc_uni.Value;
            string hsscCountry = hssc_country.Value;

            // BS
            string bsType = bs_type.Value;
            string bsDuration = bs_duration.Value;
            string bsSpecialization = bs_specialization.Value;
            int.TryParse(bs_year.Value, out int bsYear);
            decimal.TryParse(bs_cgpa.Value, out decimal bsPer);
            string bsUniversity = bs_uni.Value;
            string bsCountry = bs_country.Value;

            // MS
            string msDuration = ms_duration.Value;
            string msSpecialization = ms_specialization.Value;
            int.TryParse(ms_year.Value, out int msYear);
            decimal.TryParse(ms_cgpa.Value, out decimal msPer);
            string msUniversity = ms_uni.Value;
            string msCountry = ms_country.Value;

            // PhD
            string phdDuration = phd_duration.Value;
            string phdSpecialization = phd_specialization.Value;
            int.TryParse(phd_year.Value, out int phdYear);
            decimal.TryParse(phd_cgpa.Value, out decimal phdPer);
            string phdUniversity = phd_uni.Value;
            string phdCountry = phd_country.Value;

            // PostDoc
            string postdocDuration = postdoc_duration.Value;
            string postdocSpecialization = postdoc_specialization.Value;
            int.TryParse(postdoc_year.Value, out int postdocYear);
            decimal.TryParse(postdoc_cgpa.Value, out decimal postdocPer);
            string postdocUniversity = postdoc_uni.Value;
            string postdocCountry = postdoc_country.Value;

            // =============================================
            // STEP 1: VALIDATE SECOND DIVISION
            // =============================================
            if (SecondDivision(sscPer) || SecondDivision(hsscPer) || SecondDivision(bsPer))
            {
                return;
            }

            // =============================================
            // STEP 2: CALCULATE ACADEMIC SCORES
            // =============================================
            AcademicScores scores = CalculateAcademicScores(sscPer, hsscPer, bsPer, msPer, phdPer);

            // =============================================
            // STEP 3: SAVE EDUCATION + SCORES TO DATABASE
            // =============================================
            SaveEducationalInformation(
                userID,
                sscDuration, sscSpecialization, sscYear, sscPer, sscUniversity, sscCountry,
                hsscDuration, hsscSpecialization, hsscYear, hsscPer, hsscUniversity, hsscCountry,
                bsType, bsDuration, bsSpecialization, bsYear, bsPer, bsUniversity, bsCountry,
                msDuration, msSpecialization, msYear, msPer, msUniversity, msCountry,
                phdDuration, phdSpecialization, phdYear, phdPer, phdUniversity, phdCountry,
                postdocDuration, postdocSpecialization, postdocYear, postdocPer, postdocUniversity, postdocCountry,
                scores
            );

            // Save Other Qualifications
            var otherQualifications = CollectOtherQualificationData();
            SaveOtherQualifications(userID, otherQualifications);

            // Redirect to Reference page
            Response.Redirect("UserReference.aspx");
        }

        // =============================================
        // ACADEMIC SCORING CALCULATION
        // =============================================
        private AcademicScores CalculateAcademicScores(decimal sscPer, decimal hsscPer, decimal bsPer, decimal msPer, decimal phdPer)
        {
            var scores = new AcademicScores();

            // =============================================
            // QUALIFICATION SCORE (Max 40)
            // =============================================
            if (sscPer > 0) scores.QualificationScore += 5;   // Matric
            if (hsscPer > 0) scores.QualificationScore += 5;  // FSc
            if (bsPer > 0) scores.QualificationScore += 5;    // BS
            if (msPer > 0) scores.QualificationScore += 10;   // MS/MPhil
            if (phdPer > 0) scores.QualificationScore += 15;  // PhD

            // =============================================
            // GPA/PERCENTAGE SCORE (Max 10)
            // =============================================
            // BS GPA Score (Max 5)
            if (bsPer > 0)
            {
                scores.BSGPAScore = GetGPAScore(bsPer);
                scores.TotalGPAScore += scores.BSGPAScore;
            }

            // MS GPA Score (Max 5)
            if (msPer > 0)
            {
                scores.MSGPAScore = GetGPAScore(msPer);
                scores.TotalGPAScore += scores.MSGPAScore;
            }

            // =============================================
            // TOTAL ACADEMIC SCORE (Max 50)
            // =============================================
            scores.TotalAcademicScore = scores.QualificationScore + scores.TotalGPAScore;

            return scores;
        }

        private decimal GetGPAScore(decimal percentage)
        {
            if (percentage >= 75)
                return 5;
            else if (percentage >= 60 && percentage < 75)
                return 3;
            else
                return 0;
        }

        protected bool SecondDivision(decimal result)
        {
            // Second division check (below 60%)
            if (result >= 60)
                return false;
            else
            {
                lblMessage.Text = "Second Division in Education cannot apply!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return true;
            }
        }

        // =============================================
        // SAVE EDUCATION + SCORES
        // =============================================
        protected void SaveEducationalInformation(
            int userId,
            string sscDuration, string sscSpecialization, int sscYear, decimal sscPer, string sscUniversity, string sscCountry,
            string hsscDuration, string hsscSpecialization, int hsscYear, decimal hsscPer, string hsscUniversity, string hsscCountry,
            string bsType, string bsDuration, string bsSpecialization, int bsYear, decimal bsPer, string bsUniversity, string bsCountry,
            string msDuration, string msSpecialization, int? msYear, decimal? msPer, string msUniversity, string msCountry,
            string phdDuration, string phdSpecialization, int? phdYear, decimal? phdPer, string phdUniversity, string phdCountry,
            string postdocDuration, string postdocSpecialization, int? postdocYear, decimal? postdocPer, string postdocUniversity, string postdocCountry,
            AcademicScores scores)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                IF EXISTS (SELECT 1 FROM Education WHERE UserID=@UserID)
                BEGIN
                    UPDATE Education
                    SET
                        SSC_Duration=@SSC_Duration,
                        SSC_Specialization=@SSC_Specialization,
                        SSC_Year=@SSC_Year,
                        SSC_Percentage=@SSC_Percentage,
                        SSC_University=@SSC_University,
                        SSC_Country=@SSC_Country,

                        HSSC_Duration=@HSSC_Duration,
                        HSSC_Specialization=@HSSC_Specialization,
                        HSSC_Year=@HSSC_Year,
                        HSSC_Percentage=@HSSC_Percentage,
                        HSSC_University=@HSSC_University,
                        HSSC_Country=@HSSC_Country,

                        BS_Type=@BS_Type,
                        BS_Duration=@BS_Duration,
                        BS_Specialization=@BS_Specialization,
                        BS_Year=@BS_Year,
                        BS_Percentage=@BS_Percentage,
                        BS_University=@BS_University,
                        BS_Country=@BS_Country,

                        MS_Duration=@MS_Duration,
                        MS_Specialization=@MS_Specialization,
                        MS_Year=@MS_Year,
                        MS_Percentage=@MS_Percentage,
                        MS_University=@MS_University,
                        MS_Country=@MS_Country,

                        PhD_Duration=@PhD_Duration,
                        PhD_Specialization=@PhD_Specialization,
                        PhD_Year=@PhD_Year,
                        PhD_Percentage=@PhD_Percentage,
                        PhD_University=@PhD_University,
                        PhD_Country=@PhD_Country,

                        PostDoc_Duration=@PostDoc_Duration,
                        PostDoc_Specialization=@PostDoc_Specialization,
                        PostDoc_Year=@PostDoc_Year,
                        PostDoc_Percentage=@PostDoc_Percentage,
                        PostDoc_University=@PostDoc_University,
                        PostDoc_Country=@PostDoc_Country,

                        -- SCORES
                        BS_GPAScore=@BS_GPAScore,
                        MS_GPAScore=@MS_GPAScore,
                        QualificationScore=@QualificationScore,
                        TotalAcademicScore=@TotalAcademicScore
                    WHERE UserID=@UserID;
                END
                ELSE
                BEGIN
                    INSERT INTO Education
                    (
                        UserID,
                        SSC_Duration,SSC_Specialization,SSC_Year,SSC_Percentage,SSC_University,SSC_Country,
                        HSSC_Duration,HSSC_Specialization,HSSC_Year,HSSC_Percentage,HSSC_University,HSSC_Country,
                        BS_Type,BS_Duration,BS_Specialization,BS_Year,BS_Percentage,BS_University,BS_Country,
                        MS_Duration,MS_Specialization,MS_Year,MS_Percentage,MS_University,MS_Country,
                        PhD_Duration,PhD_Specialization,PhD_Year,PhD_Percentage,PhD_University,PhD_Country,
                        PostDoc_Duration,PostDoc_Specialization,PostDoc_Year,PostDoc_Percentage,PostDoc_University,PostDoc_Country,
                        BS_GPAScore, MS_GPAScore, QualificationScore, TotalAcademicScore
                    )
                    VALUES
                    (
                        @UserID,
                        @SSC_Duration,@SSC_Specialization,@SSC_Year,@SSC_Percentage,@SSC_University,@SSC_Country,
                        @HSSC_Duration,@HSSC_Specialization,@HSSC_Year,@HSSC_Percentage,@HSSC_University,@HSSC_Country,
                        @BS_Type,@BS_Duration,@BS_Specialization,@BS_Year,@BS_Percentage,@BS_University,@BS_Country,
                        @MS_Duration,@MS_Specialization,@MS_Year,@MS_Percentage,@MS_University,@MS_Country,
                        @PhD_Duration,@PhD_Specialization,@PhD_Year,@PhD_Percentage,@PhD_University,@PhD_Country,
                        @PostDoc_Duration,@PostDoc_Specialization,@PostDoc_Year,@PostDoc_Percentage,@PostDoc_University,@PostDoc_Country,
                        @BS_GPAScore, @MS_GPAScore, @QualificationScore, @TotalAcademicScore
                    );
                END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);

                // SSC
                cmd.Parameters.AddWithValue("@SSC_Duration", sscDuration);
                cmd.Parameters.AddWithValue("@SSC_Specialization", sscSpecialization);
                cmd.Parameters.AddWithValue("@SSC_Year", sscYear);
                cmd.Parameters.AddWithValue("@SSC_Percentage", sscPer);
                cmd.Parameters.AddWithValue("@SSC_University", sscUniversity);
                cmd.Parameters.AddWithValue("@SSC_Country", sscCountry);

                // HSSC
                cmd.Parameters.AddWithValue("@HSSC_Duration", hsscDuration);
                cmd.Parameters.AddWithValue("@HSSC_Specialization", hsscSpecialization);
                cmd.Parameters.AddWithValue("@HSSC_Year", hsscYear);
                cmd.Parameters.AddWithValue("@HSSC_Percentage", hsscPer);
                cmd.Parameters.AddWithValue("@HSSC_University", hsscUniversity);
                cmd.Parameters.AddWithValue("@HSSC_Country", hsscCountry);

                // BS
                cmd.Parameters.AddWithValue("@BS_Type", bsType);
                cmd.Parameters.AddWithValue("@BS_Duration", bsDuration);
                cmd.Parameters.AddWithValue("@BS_Specialization", bsSpecialization);
                cmd.Parameters.AddWithValue("@BS_Year", bsYear);
                cmd.Parameters.AddWithValue("@BS_Percentage", bsPer);
                cmd.Parameters.AddWithValue("@BS_University", bsUniversity);
                cmd.Parameters.AddWithValue("@BS_Country", bsCountry);

                // MS
                cmd.Parameters.AddWithValue("@MS_Duration", (object)msDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Specialization", (object)msSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Year", (object)msYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Percentage", (object)msPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_University", (object)msUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Country", (object)msCountry ?? DBNull.Value);

                // PhD
                cmd.Parameters.AddWithValue("@PhD_Duration", (object)phdDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Specialization", (object)phdSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Year", (object)phdYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Percentage", (object)phdPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_University", (object)phdUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Country", (object)phdCountry ?? DBNull.Value);

                // PostDoc
                cmd.Parameters.AddWithValue("@PostDoc_Duration", (object)postdocDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Specialization", (object)postdocSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Year", (object)postdocYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Percentage", (object)postdocPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_University", (object)postdocUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Country", (object)postdocCountry ?? DBNull.Value);

                // Scores
                cmd.Parameters.AddWithValue("@BS_GPAScore", scores.BSGPAScore);
                cmd.Parameters.AddWithValue("@MS_GPAScore", scores.MSGPAScore);
                cmd.Parameters.AddWithValue("@QualificationScore", scores.QualificationScore);
                cmd.Parameters.AddWithValue("@TotalAcademicScore", scores.TotalAcademicScore);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // =============================================
        // OTHER QUALIFICATIONS - COLLECT DATA
        // =============================================
        private List<OtherQualificationModel> CollectOtherQualificationData()
        {
            var list = new List<OtherQualificationModel>();
            var form = Request.Form;

            for (int i = 1; i <= 100; i++)
            {
                string nameKey = $"other_name_{i}";
                if (!string.IsNullOrEmpty(form[nameKey]))
                {
                    list.Add(new OtherQualificationModel
                    {
                        Name = form[nameKey],
                        Duration = form[$"other_duration_{i}"],
                        Specialization = form[$"other_specialization_{i}"],
                        Year = int.TryParse(form[$"other_year_{i}"], out int year) ? year : 0,
                        Percentage = decimal.TryParse(form[$"other_percentage_{i}"], out decimal percentage) ? percentage : 0,
                        Institute = form[$"other_institute_{i}"],
                        Country = form[$"other_country_{i}"]
                    });
                }
            }

            return list;
        }

        // =============================================
        // OTHER QUALIFICATIONS - SAVE TO DATABASE
        // =============================================
        private void SaveOtherQualifications(int userID, List<OtherQualificationModel> otherQualifications)
        {
            if (otherQualifications.Count == 0) return;

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("DELETE FROM OtherQualifications WHERE UserID = @UserID", con))
                {
                    cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                    cmd.ExecuteNonQuery();
                }

                string insertQuery = @"
                    INSERT INTO OtherQualifications (UserID, Name, Duration, Specialization, Year, Percentage, Institute, Country)
                    VALUES (@UserID, @Name, @Duration, @Specialization, @Year, @Percentage, @Institute, @Country)";

                foreach (var qual in otherQualifications)
                {
                    using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                    {
                        cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                        cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 200).Value = qual.Name;
                        cmd.Parameters.Add("@Duration", SqlDbType.NVarChar, 50).Value = qual.Duration;
                        cmd.Parameters.Add("@Specialization", SqlDbType.NVarChar, 100).Value = qual.Specialization;
                        cmd.Parameters.Add("@Year", SqlDbType.Int).Value = qual.Year;
                        cmd.Parameters.Add("@Percentage", SqlDbType.Decimal).Value = qual.Percentage;
                        cmd.Parameters.Add("@Institute", SqlDbType.NVarChar, 200).Value = qual.Institute;
                        cmd.Parameters.Add("@Country", SqlDbType.NVarChar, 100).Value = qual.Country;
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }

    // =============================================
    // ACADEMIC SCORES MODEL
    // =============================================
    public class AcademicScores
    {
        public decimal QualificationScore { get; set; }  // Max 40
        public decimal BSGPAScore { get; set; }          // Max 5
        public decimal MSGPAScore { get; set; }          // Max 5
        public decimal TotalGPAScore { get; set; }       // Max 10
        public decimal TotalAcademicScore { get; set; }  // Max 50
    }

    // =============================================
    // OTHER QUALIFICATIONS MODEL
    // =============================================
    public class OtherQualificationModel
    {
        public string Name { get; set; }
        public string Duration { get; set; }
        public string Specialization { get; set; }
        public int Year { get; set; }
        public decimal Percentage { get; set; }
        public string Institute { get; set; }
        public string Country { get; set; }
    }
}