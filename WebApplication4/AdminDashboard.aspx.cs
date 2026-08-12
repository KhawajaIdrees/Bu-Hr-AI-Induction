using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            get { return ViewState["CurrentTab"]?.ToString() ?? "all"; }
            set { ViewState["CurrentTab"] = value; }
        }

        private string CurrentSort
        {
            get { return ViewState["CurrentSort"]?.ToString() ?? "submitted"; }
            set { ViewState["CurrentSort"] = value; }
        }

        private string CurrentSearch
        {
            get { return ViewState["CurrentSearch"]?.ToString() ?? ""; }
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
            public string FullName { get; set; }
            public string Email { get; set; }
        }

        public class ApplicationRow
        {
            public int Id { get; set; }
            public ApplicantInfo Applicant { get; set; }
            public string AppliedPosition { get; set; }
            public string HiringType { get; set; }
            public double TotalScore { get; set; }
            public string Status { get; set; }
            public DateTime SubmittedAt { get; set; }
        }

        public class IncompleteApplicant
        {
            public int Id { get; set; }
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

                // Load data from database FIRST
                LoadDataFromDatabase();

                // Then bind everything
                BindAll();
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

            // ============================================
            // 1. LOAD SUBMITTED APPLICATIONS
            // ============================================
            string appQuery = @"
                SELECT 
                    u.id AS UserID,
                    p.fname + ' ' + p.lname AS FullName,
                    u.email,
                    p.cellNumber AS Phone,
                    p.gender,
                    p.nationality,
                    p.SubmittedDate,
                    p.IsSubmitted,
                    ISNULL(rp.TotalPublications, 0) AS TotalPublications,
                    ISNULL(rp.HECPublications, 0) AS HECPublications,
                    ISNULL(rp.MS_MPhil_Students, 0) AS MS_MPhil_Students,
                    ISNULL(rp.PhDStudents, 0) AS PhDStudents
                FROM Personal p
                INNER JOIN Users u ON p.userId = u.id
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
                        int totalPubs = reader["TotalPublications"] != DBNull.Value ? Convert.ToInt32(reader["TotalPublications"]) : 0;
                        int hecPubs = reader["HECPublications"] != DBNull.Value ? Convert.ToInt32(reader["HECPublications"]) : 0;
                        int msMphil = reader["MS_MPhil_Students"] != DBNull.Value ? Convert.ToInt32(reader["MS_MPhil_Students"]) : 0;
                        int phdStudents = reader["PhDStudents"] != DBNull.Value ? Convert.ToInt32(reader["PhDStudents"]) : 0;

                        double score = (totalPubs * 5) + (hecPubs * 10) + (msMphil * 3) + (phdStudents * 8);

                        var app = new ApplicationRow
                        {
                            Id = id++,
                            Applicant = new ApplicantInfo
                            {
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString()
                            },
                            AppliedPosition = "Faculty Position",
                            HiringType = "Full Time",
                            TotalScore = score,
                            Status = "Pending",
                            SubmittedAt = reader["SubmittedDate"] != DBNull.Value ? Convert.ToDateTime(reader["SubmittedDate"]) : DateTime.Now
                        };
                        applications.Add(app);
                    }
                }
            }

            // ============================================
            // 2. LOAD INCOMPLETE APPLICANTS (Not Submitted)
            // ============================================
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
                            FullName = reader["FullName"].ToString(),
                            Email = reader["Email"].ToString(),
                            Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "N/A",
                            RegisteredAt = reader["RegisteredAt"] != DBNull.Value ? Convert.ToDateTime(reader["RegisteredAt"]) : DateTime.Now
                        };
                        incomplete.Add(inc);
                    }
                }
            }

            // ============================================
            // 3. CALCULATE STATISTICS
            // ============================================
            stats = new AdminStats
            {
                TotalSubmitted = applications.Count,
                Pending = applications.Count,
                Shortlisted = 0,
                Rejected = 0,
                Hired = 0,
                IncompleteProfiles = incomplete.Count
            };
        }

        // ============================================
        // BIND ALL DATA
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

        // ============================================
        // BIND STATISTICS CARDS
        // ============================================
        private void BindStats()
        {
            // Make sure stats is not null
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

        // ============================================
        // BIND TABS
        // ============================================
        private void BindTabs()
        {
            rptTabs.DataSource = Tabs.Select(x => new { Id = x.Key, Label = x.Value }).ToList();
            rptTabs.DataBind();
        }

        // ============================================
        // BIND APPLICATIONS
        // ============================================
        private void BindApplications()
        {
            if (applications == null)
            {
                applications = new List<ApplicationRow>();
            }

            string search = CurrentSearch?.ToLower()?.Trim() ?? "";

            IEnumerable<ApplicationRow> list = applications;

            if (!string.IsNullOrEmpty(search))
            {
                list = list.Where(x =>
                    (x.Applicant?.FullName?.ToLower()?.Contains(search) ?? false) ||
                    (x.Applicant?.Email?.ToLower()?.Contains(search) ?? false) ||
                    (x.AppliedPosition?.ToLower()?.Contains(search) ?? false)
                );
            }

            if (CurrentTab != "all" && CurrentTab != "incomplete")
            {
                string status = CurrentTab.Substring(0, 1).ToUpper() + CurrentTab.Substring(1);
                list = list.Where(x => x.Status == status);
            }

            if (CurrentSort == "score")
            {
                list = list.OrderByDescending(x => x.TotalScore);
            }
            else
            {
                list = list.OrderByDescending(x => x.SubmittedAt);
            }

            var result = list.ToList();

            pnlApplicationsEmpty.Visible = result.Count == 0;
            gvApplications.DataSource = result;
            gvApplications.DataBind();
        }

        // ============================================
        // BIND INCOMPLETE APPLICANTS
        // ============================================
        private void BindIncomplete()
        {
            if (incomplete == null)
            {
                incomplete = new List<IncompleteApplicant>();
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
            gvIncomplete.DataSource = result;
            gvIncomplete.DataBind();
        }

        // ============================================
        // EVENT HANDLERS
        // ============================================
        protected void rptStats_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();
            BindAll();
        }

        protected void rptTabs_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();
            BindAll();
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentSort = ddlSort.SelectedValue;
            BindAll();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();
            if (CurrentTab == "incomplete") CurrentTab = "all";
            BindAll();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();
            if (CurrentTab == "incomplete") CurrentTab = "all";
            BindAll();
        }

        protected void btnIncompleteSearch_Click(object sender, EventArgs e)
        {
            CurrentTab = "incomplete";
            CurrentSearch = txtIncompleteSearch.Text.Trim();
            BindAll();
        }

        protected void txtIncompleteSearch_TextChanged(object sender, EventArgs e)
        {
            CurrentSearch = txtIncompleteSearch.Text.Trim();
            BindIncomplete();
        }

        protected void ddlIncompleteSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindIncomplete();
        }

        protected string FormatDate(object value)
        {
            if (value == null || value == DBNull.Value) return "";
            if (DateTime.TryParse(value.ToString(), out DateTime date))
                return date.ToString("dd MMM yyyy");
            return "";
        }

        protected string StatusBadgeClass(string status)
        {
            if (string.IsNullOrEmpty(status)) return "bg-secondary";
            switch (status.ToLower())
            {
                case "pending": return "bg-warning text-dark";
                case "shortlisted": return "bg-primary";
                case "rejected": return "bg-danger";
                case "hired": return "bg-success";
                default: return "bg-secondary";
            }
        }

        protected string GetStatIcon(string key)
        {
            switch (key.ToLower())
            {
                case "submitted": return "bi bi-people-fill icon-submitted";
                case "pending": return "bi bi-clock-history icon-pending";
                case "shortlisted": return "bi bi-person-check-fill icon-shortlisted";
                case "rejected": return "bi bi-x-circle-fill icon-rejected";
                case "hired": return "bi bi-briefcase-fill icon-hired";
                case "notsubmitted":
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