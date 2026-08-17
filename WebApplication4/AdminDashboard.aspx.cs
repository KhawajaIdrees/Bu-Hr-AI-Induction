using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace WebApplication4
{
    public partial class AdminDashboard : Page
    {
        private static readonly Dictionary<string, string> Tabs =
            new Dictionary<string, string>()
            {
                {"all", "All submitted"},
                {"pending", "Pending review"},
                {"shortlisted", "Shortlisted"},
                {"rejected", "Rejected"},
                {"hired", "Hired"},
                {"incomplete", "Not submitted yet"}
            };

        public string CurrentTab
        {
            get
            {
                if (ViewState["CurrentTab"] == null)
                    return "all";
                return ViewState["CurrentTab"].ToString();
            }
            set { ViewState["CurrentTab"] = value; }
        }

        private string CurrentSort
        {
            get
            {
                if (ViewState["CurrentSort"] == null)
                    return "submitted";
                return ViewState["CurrentSort"].ToString();
            }
            set { ViewState["CurrentSort"] = value; }
        }

        private string CurrentSearch
        {
            get
            {
                if (ViewState["CurrentSearch"] == null)
                    return "";
                return ViewState["CurrentSearch"].ToString();
            }
            set { ViewState["CurrentSearch"] = value; }
        }

        // ============================================
        // DATA MODELS
        // ============================================
        private List<ApplicationRow> applications = new List<ApplicationRow>();
        private List<IncompleteApplicant> incomplete = new List<IncompleteApplicant>();
        private AdminStats stats = new AdminStats();

        public class AdminStats
        {
            public int TotalSubmitted { get; set; }
            public int Pending { get; set; }
            public int Shortlisted { get; set; }
            public int Rejected { get; set; }
            public int Hired { get; set; }
            public int IncompleteProfiles { get; set; }
        }

        public class ApplicantInfo
        {
            public int UserId { get; set; }
            public string FullName { get; set; }
            public string Email { get; set; }
        }

        public class ApplicationRow
        {
            public int Id { get; set; }
            public ApplicantInfo Applicant { get; set; }
            public string AppliedPosition { get; set; }
            public string HiringType { get; set; }
            public string Status { get; set; }
            public DateTime SubmittedAt { get; set; }

            public decimal QualificationScore { get; set; }
            public decimal BSGPAScore { get; set; }
            public decimal MSGPAScore { get; set; }
            public decimal TotalGPAScore { get; set; }
            public decimal TotalAcademicScore { get; set; }

            public int ExperienceScore { get; set; }
            public string ExperienceLevel { get; set; }
            public int ResearchSupervisionScore { get; set; }
            public int TotalExperienceScore { get; set; }

            public int WCount { get; set; }
            public int XCount { get; set; }
            public int YCount { get; set; }
            public int TotalFundedProjects { get; set; }
            public int ResearchScore { get; set; }

            public decimal GrandTotalScore { get; set; }
            public int Rank { get; set; }
            public string EligibilityStatus { get; set; }
            public string ScoreColor { get; set; }
        }

        public class IncompleteApplicant
        {
            public int Id { get; set; }
            public int UserId { get; set; }
            public string FullName { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public DateTime RegisteredAt { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ddlSort.SelectedValue = CurrentSort;
                txtSearch.Text = CurrentSearch;
                txtIncompleteSearch.Text = CurrentSearch;

                LoadDataFromDatabase();
                BindAll();
            }
        }

        // ============================================
        // GET PROFILE IMAGE URL - FIXED to show user uploaded images
        // ============================================
        public string GetProfileImageUrl(object userId)
        {
            if (userId == null)
                return "~/Images/default-avatar.png";

            try
            {
                int id = Convert.ToInt32(userId);

                // Check if there's a PhotoPath in the Personal table
                string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
                string query = "SELECT PhotoPath FROM Personal WHERE userId = @userId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userId", id);
                    con.Open();

                    object result = cmd.ExecuteScalar();

                    if (result != null && !string.IsNullOrEmpty(result.ToString()))
                    {
                        // Return the stored PhotoPath
                        return result.ToString();
                    }
                }

                // If no PhotoPath found, check the Images folder with Profile_{id} format
                string imagePath = $"~/Images/Profile_{id}.jpg";
                string physicalPath = Server.MapPath(imagePath);

                if (System.IO.File.Exists(physicalPath))
                    return imagePath;

                imagePath = $"~/Images/Profile_{id}.png";
                physicalPath = Server.MapPath(imagePath);

                if (System.IO.File.Exists(physicalPath))
                    return imagePath;

                return "~/Images/default-avatar.png";
            }
            catch
            {
                return "~/Images/default-avatar.png";
            }
        }

        // ============================================
        // GET SCORE PERCENTAGE - For Progress Bar
        // ============================================
        public string GetScorePercentage(object score)
        {
            if (score == null)
                return "0";

            try
            {
                decimal value = Convert.ToDecimal(score);
                decimal percentage = (value / 100) * 100;
                return Math.Min(percentage, 100).ToString("F0");
            }
            catch
            {
                return "0";
            }
        }

        // ============================================
        // GET PROGRESS WIDTH - For Progress Bar Width
        // ============================================
        public string GetProgressWidth(object score)
        {
            string percentage = GetScorePercentage(score);
            return percentage + "%";
        }

        // ============================================
        // GET TOTAL SCORE DISPLAY - No decimal places
        // ============================================
        public string GetTotalScoreDisplay(object score)
        {
            if (score == null)
                return "0";

            try
            {
                decimal value = Convert.ToDecimal(score);
                return Math.Round(value, 0).ToString();
            }
            catch
            {
                return "0";
            }
        }

        // ============================================
        // GET INITIALS - For Avatar Display
        // ============================================
        public string GetInitials(object fullName)
        {
            if (fullName == null || string.IsNullOrEmpty(fullName.ToString()))
                return "?";

            string name = fullName.ToString().Trim();
            string[] parts = name.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

            if (parts.Length == 0)
                return "?";

            if (parts.Length == 1)
                return parts[0].Substring(0, 1).ToUpper();

            return (parts[0].Substring(0, 1) + parts[parts.Length - 1].Substring(0, 1)).ToUpper();
        }

        // ============================================
        // FORMAT DATE
        // ============================================
        public string FormatDate(object date)
        {
            if (date == null || date == DBNull.Value)
                return "N/A";

            try
            {
                return Convert.ToDateTime(date).ToString("dd MMM yyyy");
            }
            catch
            {
                return "N/A";
            }
        }

        // ============================================
        // LOAD DATA FROM DATABASE
        // ============================================
        private void LoadDataFromDatabase()
        {
            applications = new List<ApplicationRow>();
            incomplete = new List<IncompleteApplicant>();

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string appQuery = @"
                SELECT 
                    u.id AS UserID,
                    p.fname + ' ' + p.lname AS FullName,
                    u.email,
                    p.SubmittedDate,
                    ISNULL(e.QualificationScore, 0) AS QualificationScore,
                    ISNULL(e.BS_GPAScore, 0) AS BS_GPAScore,
                    ISNULL(e.MS_GPAScore, 0) AS MS_GPAScore,
                    ISNULL(e.TotalAcademicScore, 0) AS TotalAcademicScore,
                    e.SSC_Percentage,
                    e.HSSC_Percentage,
                    e.BS_Percentage,
                    e.MS_Percentage,
                    e.PhD_Percentage,
                    ISNULL(es.ExperienceScore, 0) AS ExperienceScore,
                    ISNULL(es.ExperienceLevel, 'N/A') AS ExperienceLevel,
                    ISNULL(es.ResearchScore, 0) AS ResearchSupervisionScore,
                    ISNULL(es.TotalExperienceScore, 0) AS TotalExperienceScore,
                    ISNULL(rp.WCount, 0) AS WCount,
                    ISNULL(rp.XCount, 0) AS XCount,
                    ISNULL(rp.YCount, 0) AS YCount,
                    ISNULL(rp.TotalFundedProjects, 0) AS TotalFundedProjects,
                    ISNULL(rp.ResearchScore, 0) AS ResearchScore
                FROM Personal p
                INNER JOIN Users u ON p.userId = u.id
                LEFT JOIN Education e ON u.id = e.UserID
                LEFT JOIN ExperienceScores es ON u.id = es.UserID
                LEFT JOIN ResearchProfile rp ON u.id = rp.user_id
                WHERE p.IsSubmitted = 1
                ORDER BY p.SubmittedDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(appQuery, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    int id = 1;
                    while (reader.Read())
                    {
                        decimal qualificationScore = reader["QualificationScore"] != DBNull.Value ? Convert.ToDecimal(reader["QualificationScore"]) : 0;
                        decimal bsGpaScore = reader["BS_GPAScore"] != DBNull.Value ? Convert.ToDecimal(reader["BS_GPAScore"]) : 0;
                        decimal msGpaScore = reader["MS_GPAScore"] != DBNull.Value ? Convert.ToDecimal(reader["MS_GPAScore"]) : 0;
                        decimal totalGpaScore = bsGpaScore + msGpaScore;
                        decimal totalAcademicScore = reader["TotalAcademicScore"] != DBNull.Value ? Convert.ToDecimal(reader["TotalAcademicScore"]) : 0;

                        int experienceScore = reader["ExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["ExperienceScore"]) : 0;
                        string experienceLevel = reader["ExperienceLevel"].ToString();
                        int researchSupervisionScore = reader["ResearchSupervisionScore"] != DBNull.Value ? Convert.ToInt32(reader["ResearchSupervisionScore"]) : 0;
                        int totalExperienceScore = reader["TotalExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["TotalExperienceScore"]) : 0;

                        int wCount = reader["WCount"] != DBNull.Value ? Convert.ToInt32(reader["WCount"]) : 0;
                        int xCount = reader["XCount"] != DBNull.Value ? Convert.ToInt32(reader["XCount"]) : 0;
                        int yCount = reader["YCount"] != DBNull.Value ? Convert.ToInt32(reader["YCount"]) : 0;
                        int fundedProjects = reader["TotalFundedProjects"] != DBNull.Value ? Convert.ToInt32(reader["TotalFundedProjects"]) : 0;
                        int researchScore = reader["ResearchScore"] != DBNull.Value ? Convert.ToInt32(reader["ResearchScore"]) : 0;

                        // ELIGIBILITY LOGIC
                        bool isEligible = true;

                        decimal sscPer = reader["SSC_Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["SSC_Percentage"]) : 0;
                        decimal hsscPer = reader["HSSC_Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["HSSC_Percentage"]) : 0;
                        decimal bsPer = reader["BS_Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["BS_Percentage"]) : 0;
                        decimal msPer = reader["MS_Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["MS_Percentage"]) : 0;
                        decimal phdPer = reader["PhD_Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["PhD_Percentage"]) : 0;

                        if (sscPer > 0 && sscPer < 60) isEligible = false;
                        if (hsscPer > 0 && hsscPer < 60) isEligible = false;
                        if (bsPer > 0 && bsPer < 60) isEligible = false;
                        if (msPer > 0 && msPer < 60) isEligible = false;
                        if (phdPer > 0 && phdPer < 60) isEligible = false;

                        int expScore = reader["ExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["ExperienceScore"]) : 0;
                        if (expScore == 0) isEligible = false;

                        int resScore = reader["ResearchScore"] != DBNull.Value ? Convert.ToInt32(reader["ResearchScore"]) : 0;
                        if (resScore == 0) isEligible = false;

                        decimal grandTotal = totalAcademicScore + totalExperienceScore + researchScore;
                        if (grandTotal < 40) isEligible = false;

                        var app = new ApplicationRow
                        {
                            Id = id++,
                            Applicant = new ApplicantInfo
                            {
                                UserId = reader["UserID"] != DBNull.Value ? Convert.ToInt32(reader["UserID"]) : 0,
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString()
                            },
                            AppliedPosition = "Faculty Position",
                            HiringType = "Full Time",
                            Status = "Pending",
                            SubmittedAt = reader["SubmittedDate"] != DBNull.Value ? Convert.ToDateTime(reader["SubmittedDate"]) : DateTime.Now,
                            QualificationScore = qualificationScore,
                            BSGPAScore = bsGpaScore,
                            MSGPAScore = msGpaScore,
                            TotalGPAScore = totalGpaScore,
                            TotalAcademicScore = totalAcademicScore,
                            ExperienceScore = experienceScore,
                            ExperienceLevel = experienceLevel,
                            ResearchSupervisionScore = researchSupervisionScore,
                            TotalExperienceScore = totalExperienceScore,
                            WCount = wCount,
                            XCount = xCount,
                            YCount = yCount,
                            TotalFundedProjects = fundedProjects,
                            ResearchScore = researchScore,
                            GrandTotalScore = grandTotal,
                            EligibilityStatus = isEligible ? "✅ Eligible" : "❌ Not Eligible",
                            ScoreColor = GetScoreColor(grandTotal)
                        };
                        applications.Add(app);
                    }
                }
            }

            // SORT BY SCORE AND ASSIGN RANK
            applications = applications.OrderByDescending(x => x.GrandTotalScore).ToList();
            int rank = 1;
            foreach (var app in applications)
            {
                app.Rank = rank++;
            }

            string incompleteQuery = @"
                SELECT 
                    u.id AS UserID,
                    p.fname + ' ' + p.lname AS FullName,
                    u.email,
                    p.cellNumber AS Phone,
                    p.CreatedAt AS RegisteredAt
                FROM Personal p
                INNER JOIN Users u ON p.userId = u.id
                WHERE p.IsSubmitted = 0 OR p.IsSubmitted IS NULL
                ORDER BY p.CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(incompleteQuery, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    int id = 1;
                    while (reader.Read())
                    {
                        var inc = new IncompleteApplicant
                        {
                            Id = id++,
                            UserId = reader["UserID"] != DBNull.Value ? Convert.ToInt32(reader["UserID"]) : 0,
                            FullName = reader["FullName"].ToString(),
                            Email = reader["Email"].ToString(),
                            Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "N/A",
                            RegisteredAt = reader["RegisteredAt"] != DBNull.Value ? Convert.ToDateTime(reader["RegisteredAt"]) : DateTime.Now
                        };
                        incomplete.Add(inc);
                    }
                }
            }

            stats = new AdminStats
            {
                TotalSubmitted = applications.Count,
                Pending = applications.Count(x => x.Status == "Pending"),
                Shortlisted = 0,
                Rejected = 0,
                Hired = 0,
                IncompleteProfiles = incomplete.Count
            };
        }

        private string GetScoreColor(decimal score)
        {
            if (score >= 80) return "text-success";
            if (score >= 60) return "text-primary";
            if (score >= 40) return "text-warning";
            return "text-danger";
        }

        // ============================================
        // BIND METHODS
        // ============================================
        private void BindAll()
        {
            BindStats();
            BindTabs();

            bool showIncomplete = CurrentTab == "incomplete";

            pnlIncomplete.Visible = showIncomplete;
            pnlApplications.Visible = !showIncomplete;
            pnlSort.Visible = !showIncomplete;

            if (showIncomplete)
            {
                BindIncomplete();
            }
            else
            {
                BindApplications();
            }
        }

        private void BindStats()
        {
            if (stats == null)
            {
                stats = new AdminStats();
            }

            var cards = new[]
            {
                new { Key = "all", Label = "Submitted", Value = stats.TotalSubmitted, Hint = "All statuses" },
                new { Key = "pending", Label = "Pending", Value = stats.Pending, Hint = "Awaiting review" },
                new { Key = "shortlisted", Label = "Shortlisted", Value = stats.Shortlisted, Hint = "" },
                new { Key = "rejected", Label = "Rejected", Value = stats.Rejected, Hint = "" },
                new { Key = "hired", Label = "Hired", Value = stats.Hired, Hint = "" },
                new { Key = "incomplete", Label = "Not submitted", Value = stats.IncompleteProfiles, Hint = "No final submit" }
            };

            rptStats.DataSource = cards;
            rptStats.DataBind();
        }

        private void BindTabs()
        {
            rptTabs.DataSource = Tabs.Select(x => new { Id = x.Key, Label = x.Value }).ToList();
            rptTabs.DataBind();
        }

        private void BindApplications()
        {
            if (applications == null || applications.Count == 0)
            {
                pnlApplicationsEmpty.Visible = true;
                rptApplicantCards.DataSource = null;
                rptApplicantCards.DataBind();
                return;
            }

            string search = CurrentSearch?.ToLower()?.Trim() ?? "";

            IEnumerable<ApplicationRow> list = applications;

            if (!string.IsNullOrEmpty(search))
            {
                list = list.Where(x =>
                    (x.Applicant?.FullName?.ToLower()?.Contains(search) ?? false) ||
                    (x.Applicant?.Email?.ToLower()?.Contains(search) ?? false)
                );
            }

            if (CurrentTab != "all" && CurrentTab != "incomplete")
            {
                string status = CurrentTab.Substring(0, 1).ToUpper() + CurrentTab.Substring(1);
                list = list.Where(x => x.Status == status);
            }

            if (CurrentSort == "score")
            {
                list = list.OrderByDescending(x => x.GrandTotalScore);
            }
            else
            {
                list = list.OrderByDescending(x => x.SubmittedAt);
            }

            var result = list.ToList();

            // REASSIGN RANK AFTER FILTERING
            int rank = 1;
            foreach (var app in result)
            {
                app.Rank = rank++;
            }

            pnlApplicationsEmpty.Visible = result.Count == 0;
            rptApplicantCards.DataSource = result;
            rptApplicantCards.DataBind();
        }

        private void BindIncomplete()
        {
            if (incomplete == null || incomplete.Count == 0)
            {
                pnlIncompleteEmpty.Visible = true;
                rptIncompleteCards.DataSource = null;
                rptIncompleteCards.DataBind();
                return;
            }

            string search = txtIncompleteSearch.Text.Trim().ToLower();

            IEnumerable<IncompleteApplicant> list = incomplete.Where(x =>
                string.IsNullOrEmpty(search) ||
                x.FullName.ToLower().Contains(search) ||
                x.Email.ToLower().Contains(search));

            if (ddlIncompleteSort.SelectedValue == "name")
            {
                list = list.OrderBy(x => x.FullName);
            }
            else
            {
                list = list.OrderByDescending(x => x.RegisteredAt);
            }

            var result = list.ToList();

            pnlIncompleteEmpty.Visible = result.Count == 0;
            rptIncompleteCards.DataSource = result;
            rptIncompleteCards.DataBind();
        }

        // ============================================
        // EVENT HANDLERS
        // ============================================
        protected void rptStats_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();
            CurrentSearch = "";
            txtSearch.Text = "";
            LoadDataFromDatabase();
            BindAll();
        }

        protected void rptTabs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();
            CurrentSearch = "";
            txtSearch.Text = "";
            LoadDataFromDatabase();
            BindAll();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentSort = ddlSort.SelectedValue;
            LoadDataFromDatabase();
            BindAll();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();
            if (CurrentTab == "incomplete")
                CurrentTab = "all";
            LoadDataFromDatabase();
            BindAll();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();
            if (CurrentTab == "incomplete")
                CurrentTab = "all";
            LoadDataFromDatabase();
            BindAll();
        }

        protected void btnIncompleteSearch_Click(object sender, EventArgs e)
        {
            CurrentTab = "incomplete";
            CurrentSearch = txtIncompleteSearch.Text.Trim();
            LoadDataFromDatabase();
            BindAll();
        }

        protected void txtIncompleteSearch_TextChanged(object sender, EventArgs e)
        {
            LoadDataFromDatabase();
            BindIncomplete();
        }

        protected void ddlIncompleteSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadDataFromDatabase();
            BindIncomplete();
        }

        protected void rptApplicantCards_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var row = (ApplicationRow)e.Item.DataItem;

                // Set progress bar width
                var progressFill = (HtmlGenericControl)e.Item.FindControl("progressFill");
                if (progressFill != null)
                {
                    string width = GetProgressWidth(row.GrandTotalScore);
                    progressFill.Style["width"] = width;
                }
            }
        }

        // ============================================
        // HELPER METHODS FOR ASPX
        // ============================================
        protected string GetStatIcon(string key)
        {
            switch (key.ToLower())
            {
                case "all":
                case "submitted": return "bi bi-people-fill icon-submitted";
                case "pending": return "bi bi-clock-history icon-pending";
                case "shortlisted": return "bi bi-person-check-fill icon-shortlisted";
                case "rejected": return "bi bi-x-circle-fill icon-rejected";
                case "hired": return "bi bi-briefcase-fill icon-hired";
                case "incomplete": return "bi bi-file-earmark-text-fill icon-incomplete";
                default: return "bi bi-bar-chart-fill";
            }
        }

        protected string GetTabClass(string tabId)
        {
            return CurrentTab == tabId ? "btn btn-primary tab-active" : "btn btn-outline-primary";
        }
    }
}