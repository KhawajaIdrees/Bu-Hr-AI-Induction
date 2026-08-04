using System;
using System.Collections.Generic;
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
            get
            {
                return ViewState["CurrentTab"]?.ToString() ?? "all";
            }
            set
            {
                ViewState["CurrentTab"] = value;
            }
        }


        private string CurrentSort
        {
            get
            {
                return ViewState["CurrentSort"]?.ToString() ?? "submitted";
            }
            set
            {
                ViewState["CurrentSort"] = value;
            }
        }


        private string CurrentSearch
        {
            get
            {
                return ViewState["CurrentSearch"]?.ToString() ?? "";
            }
            set
            {
                ViewState["CurrentSearch"] = value;
            }
        }


        private List<ApplicationRow> applications;
        private List<IncompleteApplicant> incomplete;
        private AdminStats stats;


        protected void Page_Load(object sender, EventArgs e)
        {
            LoadSampleData();


            if (!IsPostBack)
            {
                ddlSort.SelectedValue = CurrentSort;
                txtSearch.Text = CurrentSearch;
                txtIncompleteSearch.Text = CurrentSearch;
            }


            BindAll();
        }


        protected string GetStatIcon(string key)
        {
            switch (key.ToLower())
            {
                case "submitted":
                    return "bi bi-people-fill icon-submitted";

                case "pending":
                    return "bi bi-clock-history icon-pending";

                case "shortlisted":
                    return "bi bi-person-check-fill icon-shortlisted";

                case "rejected":
                    return "bi bi-x-circle-fill icon-rejected";

                case "hired":
                    return "bi bi-briefcase-fill icon-hired";

                case "notsubmitted":
                case "incomplete":
                    return "bi bi-file-earmark-text-fill icon-incomplete";

                default:
                    return "bi bi-bar-chart-fill";
            }
        }


        // ============================================================
        //  GET TAB CLASS - FOR ACTIVE TAB HIGHLIGHTING
        // ============================================================
        protected string GetTabClass(string tabId)
        {
            return CurrentTab == tabId ? "btn btn-primary tab-active" : "btn btn-outline-primary";
        }


        private void LoadSampleData()
        {
            applications = new List<ApplicationRow>()
            {
                new ApplicationRow
                {
                    Id = 1,
                    User = new User
                    {
                        FullName = "Ali Khan",
                        Email = "ali@gmail.com"
                    },
                    AppliedPosition = "Lecturer",
                    HiringType = "Full Time",
                    TotalScore = 88,
                    Status = "Pending",
                    SubmittedAt = DateTime.Now.AddDays(-3)
                },


                new ApplicationRow
                {
                    Id = 2,
                    User = new User
                    {
                        FullName = "Ahmed Raza",
                        Email = "ahmed@gmail.com"
                    },
                    AppliedPosition = "Professor",
                    HiringType = "Contract",
                    TotalScore = 95,
                    Status = "Shortlisted",
                    SubmittedAt = DateTime.Now.AddDays(-2)
                },

                new ApplicationRow
                {
                    Id = 3,
                    User = new User
                    {
                        FullName = "Bilal Ahmed",
                        Email = "bilal@gmail.com"
                    },
                    AppliedPosition = "Assistant Professor",
                    HiringType = "Full Time",
                    TotalScore = 70,
                    Status = "Rejected",
                    SubmittedAt = DateTime.Now.AddDays(-4)
                },

                new ApplicationRow
                {
                    Id = 4,
                    User = new User
                    {
                        FullName = "Bushra Malik",
                        Email = "bushra@gmail.com"
                    },
                    AppliedPosition = "Lab Engineer",
                    HiringType = "Permanent",
                    TotalScore = 98,
                    Status = "Hired",
                    SubmittedAt = DateTime.Now.AddDays(-1)
                },

                new ApplicationRow
                {
                    Id = 5,
                    User = new User
                    {
                        FullName = "Usman Tariq",
                        Email = "usman@gmail.com"
                    },
                    AppliedPosition = "Lecturer",
                    HiringType = "Full Time",
                    TotalScore = 82,
                    Status = "Pending",
                    SubmittedAt = DateTime.Now.AddDays(-5)
                },

                new ApplicationRow
                {
                    Id = 6,
                    User = new User
                    {
                        FullName = "Zara Ali",
                        Email = "zara@gmail.com"
                    },
                    AppliedPosition = "Professor",
                    HiringType = "Contract",
                    TotalScore = 91,
                    Status = "Shortlisted",
                    SubmittedAt = DateTime.Now.AddDays(-3)
                }
            };


            incomplete = new List<IncompleteApplicant>()
            {
                new IncompleteApplicant
                {
                    Id = 1,
                    FullName = "Ayesha Malik",
                    Email = "ayesha@gmail.com",
                    Phone = "03001234567",
                    RegisteredAt = DateTime.Now.AddHours(-10)
                },


                new IncompleteApplicant
                {
                    Id = 2,
                    FullName = "Sara Khan",
                    Email = "sara@gmail.com",
                    Phone = "03112223333",
                    RegisteredAt = DateTime.Now.AddDays(-1)
                }
            };


            stats = new AdminStats
            {
                TotalSubmitted = applications.Count,
                Pending = applications.Count(x => x.Status == "Pending"),
                Shortlisted = applications.Count(x => x.Status == "Shortlisted"),
                Rejected = applications.Count(x => x.Status == "Rejected"),
                Hired = applications.Count(x => x.Status == "Hired"),
                IncompleteProfiles = incomplete.Count
            };
        }



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
            var cards = new[]
            {
                new
                {
                    Key = "all",
                    Label = "Submitted",
                    Value = stats.TotalSubmitted,
                    Hint = "All statuses"
                },

                new
                {
                    Key = "pending",
                    Label = "Pending",
                    Value = stats.Pending,
                    Hint = "Awaiting review"
                },

                new
                {
                    Key = "shortlisted",
                    Label = "Shortlisted",
                    Value = stats.Shortlisted,
                    Hint = ""
                },

                new
                {
                    Key = "rejected",
                    Label = "Rejected",
                    Value = stats.Rejected,
                    Hint = ""
                },

                new
                {
                    Key = "hired",
                    Label = "Hired",
                    Value = stats.Hired,
                    Hint = ""
                },

                new
                {
                    Key = "incomplete",
                    Label = "Not submitted",
                    Value = stats.IncompleteProfiles,
                    Hint = "No final submit"
                }
            };


            rptStats.DataSource = cards;
            rptStats.DataBind();
        }



        private void BindTabs()
        {
            rptTabs.DataSource = Tabs.Select(x => new
            {
                Id = x.Key,
                Label = x.Value
            }).ToList();


            rptTabs.DataBind();
        }




        private void BindApplications()
        {
            string search = CurrentSearch?.ToLower()?.Trim() ?? "";

            IEnumerable<ApplicationRow> list = applications;

            // Apply search filter (case-insensitive)
            if (!string.IsNullOrEmpty(search))
            {
                list = list.Where(x =>
                    (x.User?.FullName?.ToLower()?.Contains(search) ?? false) ||
                    (x.User?.Email?.ToLower()?.Contains(search) ?? false) ||
                    (x.AppliedPosition?.ToLower()?.Contains(search) ?? false)
                );
            }

            // Apply tab filter
            if (CurrentTab != "all")
            {
                string status = CurrentTab.Substring(0, 1).ToUpper() + CurrentTab.Substring(1);
                list = list.Where(x => x.Status == status);
            }

            // Apply sorting
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



        protected void rptStats_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();

            BindAll();
        }



        protected void rptTabs_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            CurrentTab = e.CommandArgument.ToString();

            BindAll();
        }



        protected void ddlSort_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            CurrentSort = ddlSort.SelectedValue;

            BindAll();
        }



        protected void txtSearch_TextChanged(
            object sender,
            EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();

            if (CurrentTab == "incomplete")
            {
                CurrentTab = "all";
            }

            BindAll();
        }


        // ============================================================
        //  SEARCH BUTTON HANDLERS
        // ============================================================

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentSearch = txtSearch.Text.Trim();

            if (CurrentTab == "incomplete")
            {
                CurrentTab = "all";
            }

            BindAll();
        }


        protected void btnIncompleteSearch_Click(object sender, EventArgs e)
        {
            CurrentTab = "incomplete";
            CurrentSearch = txtIncompleteSearch.Text.Trim();

            BindAll();
        }


        // ============================================================
        //  INCOMPLETE METHODS
        // ============================================================

        private void BindIncomplete()
        {
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
            if (value == null || value == DBNull.Value)
            {
                return "";
            }


            DateTime date;


            if (DateTime.TryParse(value.ToString(), out date))
            {
                return date.ToString("dd MMM yyyy");
            }


            return "";
        }



        protected string StatusBadgeClass(string status)
        {
            if (string.IsNullOrEmpty(status))
            {
                return "bg-secondary";
            }


            switch (status.ToLower())
            {
                case "pending":
                    return "bg-warning text-dark";


                case "shortlisted":
                    return "bg-primary";


                case "rejected":
                    return "bg-danger";


                case "hired":
                    return "bg-success";


                default:
                    return "bg-secondary";
            }
        }

    }



    public class AdminStats
    {
        public int TotalSubmitted { get; set; }
        public int Pending { get; set; }
        public int Shortlisted { get; set; }
        public int Rejected { get; set; }
        public int Hired { get; set; }
        public int IncompleteProfiles { get; set; }
    }



    public class ApplicationRow
    {
        public int Id { get; set; }

        public User User { get; set; }

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



    public class CreatePostRequest
    {
        public string Title { get; set; }

        public string Content { get; set; }

        public bool Publish { get; set; }
    }
}