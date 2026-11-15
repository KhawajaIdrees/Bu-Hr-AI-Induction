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
                        ssc_regno.Value = GetString(reader, "SSC_RegNo");
                        ssc_duration.Value = reader["SSC_Duration"].ToString();
                        ssc_specialization.Value = reader["SSC_Specialization"].ToString();
                        ssc_year.Value = reader["SSC_Year"].ToString();
                        sscper.Value = reader["SSC_Percentage"].ToString();
                        ssc_uni.Value = reader["SSC_University"].ToString();
                        ssc_country.Value = reader["SSC_Country"].ToString();

                        hssc_regno.Value = GetString(reader, "HSSC_RegNo");
                        hssc_duration.Value = reader["HSSC_Duration"].ToString();
                        hssc_specialization.Value = reader["HSSC_Specialization"].ToString();
                        hssc_year.Value = reader["HSSC_Year"].ToString();
                        hsscper.Value = reader["HSSC_Percentage"].ToString();
                        hssc_uni.Value = reader["HSSC_University"].ToString();
                        hssc_country.Value = reader["HSSC_Country"].ToString();

                        bs_type.Value = reader["BS_Type"].ToString();
                        bs_regno.Value = GetString(reader, "BS_RegNo");
                        bs_duration.Value = reader["BS_Duration"].ToString();
                        bs_specialization.Value = reader["BS_Specialization"].ToString();
                        bs_year.Value = reader["BS_Year"].ToString();
                        bs_cgpa.Value = reader["BS_Percentage"].ToString();
                        bs_uni.Value = reader["BS_University"].ToString();
                        bs_country.Value = reader["BS_Country"].ToString();

                        if (reader["MS_Duration"] != DBNull.Value)
                        {
                            ms_regno.Value = GetString(reader, "MS_RegNo");
                            ms_duration.Value = reader["MS_Duration"].ToString();
                            ms_specialization.Value = reader["MS_Specialization"].ToString();
                            ms_year.Value = reader["MS_Year"].ToString();
                            ms_cgpa.Value = reader["MS_Percentage"].ToString();
                            ms_uni.Value = reader["MS_University"].ToString();
                            ms_country.Value = reader["MS_Country"].ToString();
                        }

                        if (reader["PhD_Duration"] != DBNull.Value)
                        {
                            phd_regno.Value = GetString(reader, "PhD_RegNo");
                            phd_duration.Value = reader["PhD_Duration"].ToString();
                            phd_specialization.Value = reader["PhD_Specialization"].ToString();
                            phd_year.Value = reader["PhD_Year"].ToString();
                            phd_cgpa.Value = reader["PhD_Percentage"].ToString();
                            phd_uni.Value = reader["PhD_University"].ToString();
                            phd_country.Value = reader["PhD_Country"].ToString();
                        }

                        if (reader["PostDoc_Duration"] != DBNull.Value)
                        {
                            postdoc_regno.Value = GetString(reader, "PostDoc_RegNo");
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

        private string GetString(SqlDataReader reader, string columnName)
        {
            try
            {
                int ordinal = reader.GetOrdinal(columnName);
                if (reader.IsDBNull(ordinal)) return string.Empty;
                return reader.GetValue(ordinal).ToString();
            }
            catch (IndexOutOfRangeException)
            {
                return string.Empty;
            }
        }

        // =============================================
        // SERVER-SIDE VALIDATION HELPERS
        // =============================================
        private bool AllFilled(params string[] values)
        {
            foreach (var v in values)
            {
                if (string.IsNullOrWhiteSpace(v)) return false;
            }
            return true;
        }

        private bool AnyFilled(params string[] values)
        {
            foreach (var v in values)
            {
                if (!string.IsNullOrWhiteSpace(v)) return true;
            }
            return false;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            // ---- Collect values ----
            string sscRegNo = ssc_regno.Value?.Trim() ?? "";
            string sscDuration = ssc_duration.Value?.Trim() ?? "";
            string sscSpecialization = ssc_specialization.Value?.Trim() ?? "";
            string sscYearStr = ssc_year.Value?.Trim() ?? "";
            string sscPerStr = sscper.Value?.Trim() ?? "";
            string sscUniversity = ssc_uni.Value?.Trim() ?? "";
            string sscCountry = ssc_country.Value?.Trim() ?? "";

            string hsscRegNo = hssc_regno.Value?.Trim() ?? "";
            string hsscDuration = hssc_duration.Value?.Trim() ?? "";
            string hsscSpecialization = hssc_specialization.Value?.Trim() ?? "";
            string hsscYearStr = hssc_year.Value?.Trim() ?? "";
            string hsscPerStr = hsscper.Value?.Trim() ?? "";
            string hsscUniversity = hssc_uni.Value?.Trim() ?? "";
            string hsscCountry = hssc_country.Value?.Trim() ?? "";

            string bsType = bs_type.Value?.Trim() ?? "";
            string bsRegNo = bs_regno.Value?.Trim() ?? "";
            string bsDuration = bs_duration.Value?.Trim() ?? "";
            string bsSpecialization = bs_specialization.Value?.Trim() ?? "";
            string bsYearStr = bs_year.Value?.Trim() ?? "";
            string bsPerStr = bs_cgpa.Value?.Trim() ?? "";
            string bsUniversity = bs_uni.Value?.Trim() ?? "";
            string bsCountry = bs_country.Value?.Trim() ?? "";

            string msRegNo = ms_regno.Value?.Trim() ?? "";
            string msDuration = ms_duration.Value?.Trim() ?? "";
            string msSpecialization = ms_specialization.Value?.Trim() ?? "";
            string msYearStr = ms_year.Value?.Trim() ?? "";
            string msPerStr = ms_cgpa.Value?.Trim() ?? "";
            string msUniversity = ms_uni.Value?.Trim() ?? "";
            string msCountry = ms_country.Value?.Trim() ?? "";

            string phdRegNo = phd_regno.Value?.Trim() ?? "";
            string phdDuration = phd_duration.Value?.Trim() ?? "";
            string phdSpecialization = phd_specialization.Value?.Trim() ?? "";
            string phdYearStr = phd_year.Value?.Trim() ?? "";
            string phdPerStr = phd_cgpa.Value?.Trim() ?? "";
            string phdUniversity = phd_uni.Value?.Trim() ?? "";
            string phdCountry = phd_country.Value?.Trim() ?? "";

            string postdocRegNo = postdoc_regno.Value?.Trim() ?? "";
            string postdocDuration = postdoc_duration.Value?.Trim() ?? "";
            string postdocSpecialization = postdoc_specialization.Value?.Trim() ?? "";
            string postdocYearStr = postdoc_year.Value?.Trim() ?? "";
            string postdocPerStr = postdoc_cgpa.Value?.Trim() ?? "";
            string postdocUniversity = postdoc_uni.Value?.Trim() ?? "";
            string postdocCountry = postdoc_country.Value?.Trim() ?? "";

            // ---- Server-side validation ----
            // SSC always required
            if (!AllFilled(sscRegNo, sscDuration, sscSpecialization, sscYearStr, sscPerStr, sscUniversity, sscCountry))
            {
                lblMessage.Text = "❌ SSC/O'Level: All fields are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // HSSC always required
            if (!AllFilled(hsscRegNo, hsscDuration, hsscSpecialization, hsscYearStr, hsscPerStr, hsscUniversity, hsscCountry))
            {
                lblMessage.Text = "❌ HSSC/A'Level: All fields are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // BS always required
            if (!AllFilled(bsType, bsRegNo, bsDuration, bsSpecialization, bsYearStr, bsPerStr, bsUniversity, bsCountry))
            {
                lblMessage.Text = "❌ BS/BSc: All fields are required.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // MS conditional
            bool msAny = AnyFilled(msRegNo, msDuration, msSpecialization, msYearStr, msPerStr, msUniversity, msCountry);
            bool msAll = AllFilled(msRegNo, msDuration, msSpecialization, msYearStr, msPerStr, msUniversity, msCountry);
            if (msAny && !msAll)
            {
                lblMessage.Text = "❌ Masters / MPhil: Fill all fields or leave all empty.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // PhD conditional
            bool phdAny = AnyFilled(phdRegNo, phdDuration, phdSpecialization, phdYearStr, phdPerStr, phdUniversity, phdCountry);
            bool phdAll = AllFilled(phdRegNo, phdDuration, phdSpecialization, phdYearStr, phdPerStr, phdUniversity, phdCountry);
            if (phdAny && !phdAll)
            {
                lblMessage.Text = "❌ PhD: Fill all fields or leave all empty.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // PostDoc conditional
            bool postdocAny = AnyFilled(postdocRegNo, postdocDuration, postdocSpecialization, postdocYearStr, postdocPerStr, postdocUniversity, postdocCountry);
            bool postdocAll = AllFilled(postdocRegNo, postdocDuration, postdocSpecialization, postdocYearStr, postdocPerStr, postdocUniversity, postdocCountry);
            if (postdocAny && !postdocAll)
            {
                lblMessage.Text = "❌ Post Doctorate: Fill all fields or leave all empty.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // ---- Parse numbers ----
            int.TryParse(sscYearStr, out int sscYear);
            decimal.TryParse(sscPerStr, out decimal sscPer);
            int.TryParse(hsscYearStr, out int hsscYear);
            decimal.TryParse(hsscPerStr, out decimal hsscPer);
            int.TryParse(bsYearStr, out int bsYear);
            decimal.TryParse(bsPerStr, out decimal bsPer);

            int? msYear = null; decimal? msPer = null;
            int? phdYear = null; decimal? phdPer = null;
            int? postdocYear = null; decimal? postdocPer = null;

            if (msAll) { int.TryParse(msYearStr, out int t); msYear = t; decimal.TryParse(msPerStr, out decimal d); msPer = d; }
            if (phdAll) { int.TryParse(phdYearStr, out int t); phdYear = t; decimal.TryParse(phdPerStr, out decimal d); phdPer = d; }
            if (postdocAll) { int.TryParse(postdocYearStr, out int t); postdocYear = t; decimal.TryParse(postdocPerStr, out decimal d); postdocPer = d; }

            // ---- Existing Second Division check ----
            if (SecondDivision(sscPer) || SecondDivision(hsscPer) || SecondDivision(bsPer))
            {
                return;
            }

            // ---- Calculate scores ----
            AcademicScores scores = CalculateAcademicScores(
                sscPer, hsscPer, bsPer,
                msPer ?? 0, phdPer ?? 0, postdocPer ?? 0);

            // ---- Save ----
            SaveEducationalInformation(
                userID,
                sscRegNo, sscDuration, sscSpecialization, sscYear, sscPer, sscUniversity, sscCountry,
                hsscRegNo, hsscDuration, hsscSpecialization, hsscYear, hsscPer, hsscUniversity, hsscCountry,
                bsType, bsRegNo, bsDuration, bsSpecialization, bsYear, bsPer, bsUniversity, bsCountry,
                msAll ? msRegNo : null, msAll ? msDuration : null, msAll ? msSpecialization : null, msYear, msPer, msAll ? msUniversity : null, msAll ? msCountry : null,
                phdAll ? phdRegNo : null, phdAll ? phdDuration : null, phdAll ? phdSpecialization : null, phdYear, phdPer, phdAll ? phdUniversity : null, phdAll ? phdCountry : null,
                postdocAll ? postdocRegNo : null, postdocAll ? postdocDuration : null, postdocAll ? postdocSpecialization : null, postdocYear, postdocPer, postdocAll ? postdocUniversity : null, postdocAll ? postdocCountry : null,
                scores
            );

            // ---- Other Qualifications ----
            var otherQualifications = CollectOtherQualificationData();
            SaveOtherQualifications(userID, otherQualifications);

            Response.Redirect("UserReference.aspx");
        }

        private AcademicScores CalculateAcademicScores(
            decimal sscPer, decimal hsscPer, decimal bsPer,
            decimal msPer, decimal phdPer, decimal postdocPer)
        {
            var scores = new AcademicScores();

            scores.MatricScore = sscPer > 0 ? 1 : 0;
            scores.FScScore = hsscPer > 0 ? 3 : 0;

            if (bsPer >= 75) scores.BSScore = 6;
            else if (bsPer >= 60) scores.BSScore = 4;
            else scores.BSScore = 0;

            if (msPer >= 75) scores.MSScore = 9;
            else if (msPer >= 60) scores.MSScore = 7;
            else scores.MSScore = 0;

            scores.PhDScore = phdPer > 0 ? 10 : 0;
            scores.PostDocScore = postdocPer > 0 ? 11 : 0;

            scores.TotalAcademicScore = scores.MatricScore
                                      + scores.FScScore
                                      + scores.BSScore
                                      + scores.MSScore
                                      + scores.PhDScore
                                      + scores.PostDocScore;

            if (scores.TotalAcademicScore > 40) scores.TotalAcademicScore = 40;

            scores.QualificationScore = scores.TotalAcademicScore;
            scores.CGPA_Score = 0;
            scores.TotalGPAScore = 0;

            return scores;
        }

        private decimal GetGPAScore(decimal percentage)
        {
            if (percentage >= 75) return 5;
            else if (percentage >= 60 && percentage < 75) return 3;
            else return 0;
        }

        protected bool SecondDivision(decimal result)
        {
            if (result >= 60)
                return false;
            else
            {
                lblMessage.Text = "Second Division in Education cannot apply!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return true;
            }
        }

        protected void SaveEducationalInformation(
            int userId,
            string sscRegNo, string sscDuration, string sscSpecialization, int sscYear, decimal sscPer, string sscUniversity, string sscCountry,
            string hsscRegNo, string hsscDuration, string hsscSpecialization, int hsscYear, decimal hsscPer, string hsscUniversity, string hsscCountry,
            string bsType, string bsRegNo, string bsDuration, string bsSpecialization, int bsYear, decimal bsPer, string bsUniversity, string bsCountry,
            string msRegNo, string msDuration, string msSpecialization, int? msYear, decimal? msPer, string msUniversity, string msCountry,
            string phdRegNo, string phdDuration, string phdSpecialization, int? phdYear, decimal? phdPer, string phdUniversity, string phdCountry,
            string postdocRegNo, string postdocDuration, string postdocSpecialization, int? postdocYear, decimal? postdocPer, string postdocUniversity, string postdocCountry,
            AcademicScores scores)
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"
                IF EXISTS (SELECT 1 FROM Education WHERE UserID=@UserID)
                BEGIN
                    UPDATE Education SET
                        SSC_RegNo=@SSC_RegNo, SSC_Duration=@SSC_Duration, SSC_Specialization=@SSC_Specialization,
                        SSC_Year=@SSC_Year, SSC_Percentage=@SSC_Percentage, SSC_University=@SSC_University, SSC_Country=@SSC_Country,

                        HSSC_RegNo=@HSSC_RegNo, HSSC_Duration=@HSSC_Duration, HSSC_Specialization=@HSSC_Specialization,
                        HSSC_Year=@HSSC_Year, HSSC_Percentage=@HSSC_Percentage, HSSC_University=@HSSC_University, HSSC_Country=@HSSC_Country,

                        BS_Type=@BS_Type, BS_RegNo=@BS_RegNo, BS_Duration=@BS_Duration, BS_Specialization=@BS_Specialization,
                        BS_Year=@BS_Year, BS_Percentage=@BS_Percentage, BS_University=@BS_University, BS_Country=@BS_Country,

                        MS_RegNo=@MS_RegNo, MS_Duration=@MS_Duration, MS_Specialization=@MS_Specialization,
                        MS_Year=@MS_Year, MS_Percentage=@MS_Percentage, MS_University=@MS_University, MS_Country=@MS_Country,

                        PhD_RegNo=@PhD_RegNo, PhD_Duration=@PhD_Duration, PhD_Specialization=@PhD_Specialization,
                        PhD_Year=@PhD_Year, PhD_Percentage=@PhD_Percentage, PhD_University=@PhD_University, PhD_Country=@PhD_Country,

                        PostDoc_RegNo=@PostDoc_RegNo, PostDoc_Duration=@PostDoc_Duration, PostDoc_Specialization=@PostDoc_Specialization,
                        PostDoc_Year=@PostDoc_Year, PostDoc_Percentage=@PostDoc_Percentage, PostDoc_University=@PostDoc_University, PostDoc_Country=@PostDoc_Country,

                        Matric_Score=@Matric_Score, FSc_Score=@FSc_Score, BS_Score=@BS_Score, MS_Score=@MS_Score,
                        PhD_Score=@PhD_Score, PostDoc_Score=@PostDoc_Score,
                        QualificationScore=@QualificationScore, TotalAcademicScore=@TotalAcademicScore
                    WHERE UserID=@UserID;
                END
                ELSE
                BEGIN
                    INSERT INTO Education
                    (
                        UserID,
                        SSC_RegNo, SSC_Duration,SSC_Specialization,SSC_Year,SSC_Percentage,SSC_University,SSC_Country,
                        HSSC_RegNo, HSSC_Duration,HSSC_Specialization,HSSC_Year,HSSC_Percentage,HSSC_University,HSSC_Country,
                        BS_Type, BS_RegNo, BS_Duration,BS_Specialization,BS_Year,BS_Percentage,BS_University,BS_Country,
                        MS_RegNo, MS_Duration,MS_Specialization,MS_Year,MS_Percentage,MS_University,MS_Country,
                        PhD_RegNo, PhD_Duration,PhD_Specialization,PhD_Year,PhD_Percentage,PhD_University,PhD_Country,
                        PostDoc_RegNo, PostDoc_Duration,PostDoc_Specialization,PostDoc_Year,PostDoc_Percentage,PostDoc_University,PostDoc_Country,
                        Matric_Score, FSc_Score, BS_Score, MS_Score, PhD_Score, PostDoc_Score,
                        QualificationScore, TotalAcademicScore
                    )
                    VALUES
                    (
                        @UserID,
                        @SSC_RegNo, @SSC_Duration,@SSC_Specialization,@SSC_Year,@SSC_Percentage,@SSC_University,@SSC_Country,
                        @HSSC_RegNo, @HSSC_Duration,@HSSC_Specialization,@HSSC_Year,@HSSC_Percentage,@HSSC_University,@HSSC_Country,
                        @BS_Type, @BS_RegNo, @BS_Duration,@BS_Specialization,@BS_Year,@BS_Percentage,@BS_University,@BS_Country,
                        @MS_RegNo, @MS_Duration,@MS_Specialization,@MS_Year,@MS_Percentage,@MS_University,@MS_Country,
                        @PhD_RegNo, @PhD_Duration,@PhD_Specialization,@PhD_Year,@PhD_Percentage,@PhD_University,@PhD_Country,
                        @PostDoc_RegNo, @PostDoc_Duration,@PostDoc_Specialization,@PostDoc_Year,@PostDoc_Percentage,@PostDoc_University,@PostDoc_Country,
                        @Matric_Score, @FSc_Score, @BS_Score, @MS_Score, @PhD_Score, @PostDoc_Score,
                        @QualificationScore, @TotalAcademicScore
                    );
                END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);

                cmd.Parameters.AddWithValue("@SSC_RegNo", (object)sscRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@SSC_Duration", sscDuration);
                cmd.Parameters.AddWithValue("@SSC_Specialization", sscSpecialization);
                cmd.Parameters.AddWithValue("@SSC_Year", sscYear);
                cmd.Parameters.AddWithValue("@SSC_Percentage", sscPer);
                cmd.Parameters.AddWithValue("@SSC_University", sscUniversity);
                cmd.Parameters.AddWithValue("@SSC_Country", sscCountry);

                cmd.Parameters.AddWithValue("@HSSC_RegNo", (object)hsscRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@HSSC_Duration", hsscDuration);
                cmd.Parameters.AddWithValue("@HSSC_Specialization", hsscSpecialization);
                cmd.Parameters.AddWithValue("@HSSC_Year", hsscYear);
                cmd.Parameters.AddWithValue("@HSSC_Percentage", hsscPer);
                cmd.Parameters.AddWithValue("@HSSC_University", hsscUniversity);
                cmd.Parameters.AddWithValue("@HSSC_Country", hsscCountry);

                cmd.Parameters.AddWithValue("@BS_Type", bsType);
                cmd.Parameters.AddWithValue("@BS_RegNo", (object)bsRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@BS_Duration", bsDuration);
                cmd.Parameters.AddWithValue("@BS_Specialization", bsSpecialization);
                cmd.Parameters.AddWithValue("@BS_Year", bsYear);
                cmd.Parameters.AddWithValue("@BS_Percentage", bsPer);
                cmd.Parameters.AddWithValue("@BS_University", bsUniversity);
                cmd.Parameters.AddWithValue("@BS_Country", bsCountry);

                cmd.Parameters.AddWithValue("@MS_RegNo", (object)msRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Duration", (object)msDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Specialization", (object)msSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Year", (object)msYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Percentage", (object)msPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_University", (object)msUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@MS_Country", (object)msCountry ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@PhD_RegNo", (object)phdRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Duration", (object)phdDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Specialization", (object)phdSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Year", (object)phdYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Percentage", (object)phdPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_University", (object)phdUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PhD_Country", (object)phdCountry ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@PostDoc_RegNo", (object)postdocRegNo ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Duration", (object)postdocDuration ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Specialization", (object)postdocSpecialization ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Year", (object)postdocYear ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Percentage", (object)postdocPer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_University", (object)postdocUniversity ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@PostDoc_Country", (object)postdocCountry ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@Matric_Score", scores.MatricScore);
                cmd.Parameters.AddWithValue("@FSc_Score", scores.FScScore);
                cmd.Parameters.AddWithValue("@BS_Score", scores.BSScore);
                cmd.Parameters.AddWithValue("@MS_Score", scores.MSScore);
                cmd.Parameters.AddWithValue("@PhD_Score", scores.PhDScore);
                cmd.Parameters.AddWithValue("@PostDoc_Score", scores.PostDocScore);
                cmd.Parameters.AddWithValue("@QualificationScore", scores.QualificationScore);
                cmd.Parameters.AddWithValue("@TotalAcademicScore", scores.TotalAcademicScore);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

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

    public class AcademicScores
    {
        public decimal MatricScore { get; set; }
        public decimal FScScore { get; set; }
        public decimal BSScore { get; set; }
        public decimal MSScore { get; set; }
        public decimal PhDScore { get; set; }
        public decimal PostDocScore { get; set; }
        public decimal QualificationScore { get; set; }
        public decimal CGPA_Score { get; set; }
        public decimal TotalGPAScore { get; set; }
        public decimal TotalAcademicScore { get; set; }
    }

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