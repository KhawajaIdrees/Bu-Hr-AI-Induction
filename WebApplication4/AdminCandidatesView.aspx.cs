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
    public partial class AdminCandidatesView : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
        private string currentTab = "all";
        private string currentSearch = "";
        private int selectedCandidateId = 0;
        private int currentPageSize = 0; // 0 means show all

        public class CandidateRow
        {
            public int Id { get; set; }
            public string FullName { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public string AppliedPosition { get; set; }
            public string Status { get; set; }
            public decimal TotalScore { get; set; }
            public string Initials { get; set; }
            public string StatusClass { get; set; }
            public DateTime SubmittedDate { get; set; }
            public string ExperienceLevel { get; set; }
            public string EligibilityStatus { get; set; }
            public decimal AcademicScore { get; set; }
            public int ExperienceScore { get; set; }
            public int ResearchScore { get; set; }
        }

        public class EducationItem
        {
            public string Degree { get; set; }
            public string Institute { get; set; }
            public int Year { get; set; }
            public decimal Percentage { get; set; }
            public string StatusText { get; set; }
        }

        public class ExperienceItem
        {
            public string Organization { get; set; }
            public string Position { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime? EndDate { get; set; }
        }

        public class PublicationItem
        {
            public string Title { get; set; }
            public string JournalName { get; set; }
            public int Year { get; set; }
            public string Category { get; set; }
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
                string tab = Request.QueryString["tab"];
                if (!string.IsNullOrEmpty(tab))
                {
                    currentTab = tab;
                }

                string selectedId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(selectedId) && int.TryParse(selectedId, out int id))
                {
                    selectedCandidateId = id;
                }

                // Set default dropdown selection
                ddlPageSize.SelectedValue = "all";
                currentPageSize = 0;

                // Ensure JobApplication table exists with Status column
                EnsureJobApplicationTableExists();

                BindAll();
            }
            else
            {
                // On postback, preserve the current tab from ViewState or Request
                if (ViewState["CurrentTab"] != null)
                {
                    currentTab = ViewState["CurrentTab"].ToString();
                }
                else
                {
                    string tab = Request.QueryString["tab"];
                    if (!string.IsNullOrEmpty(tab))
                    {
                        currentTab = tab;
                    }
                }
            }
        }

        // ============================================
        // ENSURE JOB APPLICATION TABLE EXISTS
        // ============================================
        private void EnsureJobApplicationTableExists()
        {
            try
            {
                string createTableQuery = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='JobApplication' AND xtype='U')
                    BEGIN
                        CREATE TABLE JobApplication (
                            Id INT IDENTITY(1,1) PRIMARY KEY,
                            UserId INT NOT NULL,
                            Status NVARCHAR(50) DEFAULT 'Pending',
                            UpdatedDate DATETIME DEFAULT GETDATE()
                        )
                    END
                    ELSE
                    BEGIN
                        -- Check if Status column exists, if not add it
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('JobApplication') AND name = 'Status')
                        BEGIN
                            ALTER TABLE JobApplication ADD Status NVARCHAR(50) DEFAULT 'Pending'
                        END
                        
                        -- Check if UpdatedDate column exists, if not add it
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('JobApplication') AND name = 'UpdatedDate')
                        BEGIN
                            ALTER TABLE JobApplication ADD UpdatedDate DATETIME DEFAULT GETDATE()
                        END
                    END";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(createTableQuery, con))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error ensuring JobApplication table exists: " + ex.Message);
            }
        }

        // ============================================
        // GET PROFILE IMAGE URL - Shows user uploaded images
        // ============================================
        public string GetProfileImageUrl(object userId)
        {
            if (userId == null)
                return "~/Images/default-avatar.png";

            try
            {
                int id = Convert.ToInt32(userId);

                // Check if there's a PhotoPath in the Personal table
                string connectionString = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
                string query = "SELECT PhotoPath FROM Personal WHERE userId = @userId";

                using (SqlConnection con = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userId", id);
                    con.Open();

                    object result = cmd.ExecuteScalar();

                    if (result != null && !string.IsNullOrEmpty(result.ToString()))
                    {
                        // Return the stored PhotoPath from the database
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

        private List<CandidateRow> GetAllCandidates()
        {
            var candidates = new List<CandidateRow>();

            // First, check if the JobApplication table has the Status column
            bool hasJobApplicationTable = false;
            bool hasStatusColumn = false;

            try
            {
                string checkTableQuery = "SELECT COUNT(*) FROM sysobjects WHERE name='JobApplication' AND xtype='U'";
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(checkTableQuery, con))
                    {
                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        hasJobApplicationTable = count > 0;
                    }
                }

                if (hasJobApplicationTable)
                {
                    string checkColumnQuery = "SELECT COUNT(*) FROM sys.columns WHERE object_id = OBJECT_ID('JobApplication') AND name = 'Status'";
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand(checkColumnQuery, con))
                        {
                            int count = Convert.ToInt32(cmd.ExecuteScalar());
                            hasStatusColumn = count > 0;
                        }
                    }
                }
            }
            catch
            {
                hasJobApplicationTable = false;
                hasStatusColumn = false;
            }

            string query;

            if (hasJobApplicationTable && hasStatusColumn)
            {
                // Query with JobApplication table and Status column
                query = @"
                    SELECT 
                        u.id AS UserId,
                        p.fname + ' ' + p.lname AS FullName,
                        u.email,
                        p.cellNumber AS Phone,
                        ISNULL(e.TotalAcademicScore, 0) AS AcademicScore,
                        ISNULL(es.TotalExperienceScore, 0) AS ExperienceScore,
                        ISNULL(rp.ResearchScore, 0) AS ResearchScore,
                        ISNULL(es.ExperienceLevel, 'N/A') AS ExperienceLevel,
                        ISNULL(p.SubmittedDate, GETDATE()) AS SubmittedDate,
                        CASE 
                            WHEN ISNULL(e.TotalAcademicScore, 0) + ISNULL(es.TotalExperienceScore, 0) + ISNULL(rp.ResearchScore, 0) >= 40 
                            AND ISNULL(es.ExperienceScore, 0) > 0 
                            AND ISNULL(rp.ResearchScore, 0) > 0 
                            THEN '✅ Eligible'
                            ELSE '❌ Not Eligible'
                        END AS EligibilityStatus,
                        ISNULL(e.TotalAcademicScore, 0) + ISNULL(es.TotalExperienceScore, 0) + ISNULL(rp.ResearchScore, 0) AS TotalScore,
                        'Lecturer' AS AppliedPosition,
                        ISNULL(ja.Status, 'Pending') AS Status
                    FROM Personal p
                    INNER JOIN Users u ON p.userId = u.id
                    LEFT JOIN Education e ON u.id = e.UserID
                    LEFT JOIN ExperienceScores es ON u.id = es.UserID
                    LEFT JOIN ResearchProfile rp ON u.id = rp.user_id
                    LEFT JOIN JobApplication ja ON u.id = ja.UserId
                    WHERE p.IsSubmitted = 1
                    ORDER BY p.SubmittedDate DESC";
            }
            else
            {
                // Fallback query without JobApplication table
                query = @"
                    SELECT 
                        u.id AS UserId,
                        p.fname + ' ' + p.lname AS FullName,
                        u.email,
                        p.cellNumber AS Phone,
                        ISNULL(e.TotalAcademicScore, 0) AS AcademicScore,
                        ISNULL(es.TotalExperienceScore, 0) AS ExperienceScore,
                        ISNULL(rp.ResearchScore, 0) AS ResearchScore,
                        ISNULL(es.ExperienceLevel, 'N/A') AS ExperienceLevel,
                        ISNULL(p.SubmittedDate, GETDATE()) AS SubmittedDate,
                        CASE 
                            WHEN ISNULL(e.TotalAcademicScore, 0) + ISNULL(es.TotalExperienceScore, 0) + ISNULL(rp.ResearchScore, 0) >= 40 
                            AND ISNULL(es.ExperienceScore, 0) > 0 
                            AND ISNULL(rp.ResearchScore, 0) > 0 
                            THEN '✅ Eligible'
                            ELSE '❌ Not Eligible'
                        END AS EligibilityStatus,
                        ISNULL(e.TotalAcademicScore, 0) + ISNULL(es.TotalExperienceScore, 0) + ISNULL(rp.ResearchScore, 0) AS TotalScore,
                        'Lecturer' AS AppliedPosition,
                        'Pending' AS Status
                    FROM Personal p
                    INNER JOIN Users u ON p.userId = u.id
                    LEFT JOIN Education e ON u.id = e.UserID
                    LEFT JOIN ExperienceScores es ON u.id = es.UserID
                    LEFT JOIN ResearchProfile rp ON u.id = rp.user_id
                    WHERE p.IsSubmitted = 1
                    ORDER BY p.SubmittedDate DESC";
            }

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string fullName = reader["FullName"].ToString();
                        string[] nameParts = fullName.Split(' ');
                        string initials = "";
                        if (nameParts.Length > 0 && nameParts[0].Length > 0) initials += nameParts[0][0];
                        if (nameParts.Length > 1 && nameParts[1].Length > 0) initials += nameParts[1][0];

                        decimal totalScore = reader["TotalScore"] != DBNull.Value ? Convert.ToDecimal(reader["TotalScore"]) : 0;
                        string status = reader["Status"] != DBNull.Value ? reader["Status"].ToString() : "Pending";

                        var candidate = new CandidateRow
                        {
                            Id = Convert.ToInt32(reader["UserId"]),
                            FullName = fullName,
                            Email = reader["Email"].ToString(),
                            Phone = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "Not provided",
                            AppliedPosition = reader["AppliedPosition"].ToString(),
                            Status = status,
                            TotalScore = totalScore,
                            Initials = initials.ToUpper(),
                            StatusClass = status.ToLower(),
                            SubmittedDate = reader["SubmittedDate"] != DBNull.Value ? Convert.ToDateTime(reader["SubmittedDate"]) : DateTime.Now,
                            ExperienceLevel = reader["ExperienceLevel"].ToString(),
                            EligibilityStatus = reader["EligibilityStatus"].ToString(),
                            AcademicScore = reader["AcademicScore"] != DBNull.Value ? Convert.ToDecimal(reader["AcademicScore"]) : 0,
                            ExperienceScore = reader["ExperienceScore"] != DBNull.Value ? Convert.ToInt32(reader["ExperienceScore"]) : 0,
                            ResearchScore = reader["ResearchScore"] != DBNull.Value ? Convert.ToInt32(reader["ResearchScore"]) : 0
                        };
                        candidates.Add(candidate);
                    }
                }
            }

            return candidates;
        }

        private void BindAll()
        {
            // Store current tab in ViewState to preserve across postbacks
            ViewState["CurrentTab"] = currentTab;

            BindCandidates();
            UpdateTabStyles();

            if (selectedCandidateId > 0)
            {
                LoadCandidateDetails(selectedCandidateId);
            }
            else
            {
                pnlDetails.Visible = false;
                pnlSelect.Visible = true;
            }
        }

        private void BindCandidates()
        {
            var candidates = GetAllCandidates();

            if (!string.IsNullOrEmpty(currentSearch))
            {
                string search = currentSearch.ToLower();
                candidates = candidates.Where(x =>
                    x.FullName.ToLower().Contains(search) ||
                    x.Email.ToLower().Contains(search) ||
                    x.AppliedPosition.ToLower().Contains(search)
                ).ToList();
            }

            // Apply status filter based on current tab
            if (currentTab != "all")
            {
                string targetStatus = char.ToUpper(currentTab[0]) + currentTab.Substring(1);
                candidates = candidates.Where(x => string.Equals(x.Status, targetStatus, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            candidates = candidates.OrderByDescending(x => x.TotalScore).ToList();

            // Apply page size filter
            if (currentPageSize > 0 && candidates.Count > currentPageSize)
            {
                candidates = candidates.Take(currentPageSize).ToList();
            }

            if (candidates.Count == 0)
            {
                pnlEmpty.Visible = true;
                rptCandidates.DataSource = null;
                rptCandidates.DataBind();
            }
            else
            {
                pnlEmpty.Visible = false;
                rptCandidates.DataSource = candidates;
                rptCandidates.DataBind();
            }
        }

        private void UpdateTabStyles()
        {
            btnAll.CssClass = currentTab == "all" ? "tab-btn active" : "tab-btn";
            btnPending.CssClass = currentTab == "pending" ? "tab-btn active" : "tab-btn";
            btnShortlisted.CssClass = currentTab == "shortlisted" ? "tab-btn active" : "tab-btn";
            btnRejected.CssClass = currentTab == "rejected" ? "tab-btn active" : "tab-btn";
            btnHired.CssClass = currentTab == "hired" ? "tab-btn active" : "tab-btn";
        }

        protected void rptCandidates_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var candidate = (CandidateRow)e.Item.DataItem;
                var btn = (LinkButton)e.Item.FindControl("btnCandidate");

                if (candidate != null && btn != null)
                {
                    if (selectedCandidateId > 0 && candidate.Id == selectedCandidateId)
                    {
                        btn.CssClass = "candidate-card active w-100 text-start text-decoration-none d-block";
                    }
                }
            }
        }

        protected void btnCandidate_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            selectedCandidateId = Convert.ToInt32(btn.CommandArgument);
            Response.Redirect($"AdminCandidatesView.aspx?id={selectedCandidateId}&tab={currentTab}");
        }

        private void LoadCandidateDetails(int candidateId)
        {
            var candidates = GetAllCandidates();
            var candidate = candidates.FirstOrDefault(x => x.Id == candidateId);

            if (candidate == null)
            {
                pnlDetails.Visible = false;
                pnlSelect.Visible = true;
                return;
            }

            pnlDetails.Visible = true;
            pnlSelect.Visible = false;

            // Set the profile image for the large view
            imgProfileLarge.ImageUrl = GetProfileImageUrl(candidateId);

            // Candidate Header
            lblFullName.Text = candidate.FullName;
            lblPosition.Text = candidate.AppliedPosition;
            lblEmail.Text = candidate.Email;
            lblPhone.Text = candidate.Phone;
            lblSubmittedDate.Text = candidate.SubmittedDate.ToString("dd MMM yyyy");
            lblTotal.Text = candidate.TotalScore.ToString("F0");

            // Scores
            lblAcademic.Text = candidate.AcademicScore.ToString("F0");
            lblExperience.Text = candidate.ExperienceScore.ToString();
            lblResearch.Text = candidate.ResearchScore.ToString();

            // Status dropdown - set to match candidate's status
            if (ddlStatus.Items.FindByValue(candidate.Status) != null)
            {
                ddlStatus.SelectedValue = candidate.Status;
            }
            else
            {
                ddlStatus.SelectedValue = "Pending";
            }

            // Load sections
            LoadEducation(candidateId);
            LoadExperience(candidateId);
            LoadPublications(candidateId);
        }

        private void LoadEducation(int userId)
        {
            var education = new List<EducationItem>();

            string query = @"
                SELECT 
                    'SSC/O''Level' AS Degree,
                    SSC_University AS Institute,
                    SSC_Year AS Year,
                    SSC_Percentage AS Percentage,
                    'Completed' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND SSC_University IS NOT NULL
                UNION ALL
                SELECT 
                    'HSSC/A''Level' AS Degree,
                    HSSC_University AS Institute,
                    HSSC_Year AS Year,
                    HSSC_Percentage AS Percentage,
                    'Completed' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND HSSC_University IS NOT NULL
                UNION ALL
                SELECT 
                    'BS' AS Degree,
                    BS_University AS Institute,
                    BS_Year AS Year,
                    BS_Percentage AS Percentage,
                    'Graduated' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND BS_University IS NOT NULL
                UNION ALL
                SELECT 
                    'MS/MPhil' AS Degree,
                    MS_University AS Institute,
                    MS_Year AS Year,
                    MS_Percentage AS Percentage,
                    'Graduated' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND MS_University IS NOT NULL
                UNION ALL
                SELECT 
                    'PhD' AS Degree,
                    PhD_University AS Institute,
                    PhD_Year AS Year,
                    PhD_Percentage AS Percentage,
                    'Graduated' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND PhD_University IS NOT NULL
                UNION ALL
                SELECT 
                    'Post Doctorate' AS Degree,
                    PostDoc_University AS Institute,
                    PostDoc_Year AS Year,
                    PostDoc_Percentage AS Percentage,
                    'Completed' AS StatusText
                FROM Education
                WHERE UserID = @UserId AND PostDoc_University IS NOT NULL";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        education.Add(new EducationItem
                        {
                            Degree = reader["Degree"].ToString(),
                            Institute = reader["Institute"].ToString(),
                            Year = reader["Year"] != DBNull.Value ? Convert.ToInt32(reader["Year"]) : 0,
                            Percentage = reader["Percentage"] != DBNull.Value ? Convert.ToDecimal(reader["Percentage"]) : 0,
                            StatusText = reader["StatusText"].ToString()
                        });
                    }
                }
            }

            if (education.Count == 0)
            {
                rptEducation.DataSource = null;
                rptEducation.DataBind();
                pnlNoEducation.Visible = true;
            }
            else
            {
                pnlNoEducation.Visible = false;
                rptEducation.DataSource = education;
                rptEducation.DataBind();
            }
        }

        private void LoadExperience(int userId)
        {
            var experience = new List<ExperienceItem>();

            string query = @"
                SELECT 
                    OrganizationName AS Organization,
                    PositionTitle AS Position,
                    StartDate,
                    EndDate
                FROM WorkExperience
                WHERE UserId = @UserId
                ORDER BY StartDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        experience.Add(new ExperienceItem
                        {
                            Organization = reader["Organization"].ToString(),
                            Position = reader["Position"].ToString(),
                            StartDate = Convert.ToDateTime(reader["StartDate"]),
                            EndDate = reader["EndDate"] != DBNull.Value ? Convert.ToDateTime(reader["EndDate"]) : (DateTime?)null
                        });
                    }
                }
            }

            if (experience.Count == 0)
            {
                rptExperience.DataSource = null;
                rptExperience.DataBind();
                pnlNoExperience.Visible = true;
            }
            else
            {
                pnlNoExperience.Visible = false;
                rptExperience.DataSource = experience;
                rptExperience.DataBind();
            }
        }

        private void LoadPublications(int userId)
        {
            var publications = new List<PublicationItem>();

            string query = @"
                SELECT 
                    ArticleTitle AS Title,
                    JournalName,
                    PublicationYear AS Year,
                    Category
                FROM Publications
                WHERE user_id = @UserId
                ORDER BY PublicationYear DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        publications.Add(new PublicationItem
                        {
                            Title = reader["Title"].ToString(),
                            JournalName = reader["JournalName"].ToString(),
                            Year = reader["Year"] != DBNull.Value ? Convert.ToInt32(reader["Year"]) : 0,
                            Category = reader["Category"].ToString()
                        });
                    }
                }
            }

            if (publications.Count == 0)
            {
                rptPublications.DataSource = null;
                rptPublications.DataBind();
                pnlNoPublications.Visible = true;
            }
            else
            {
                pnlNoPublications.Visible = false;
                rptPublications.DataSource = publications;
                rptPublications.DataBind();
            }
        }

        protected void btnTab_Click(object sender, EventArgs e)
        {
            var btn = (LinkButton)sender;
            currentTab = btn.CommandArgument;
            selectedCandidateId = 0;
            pnlDetails.Visible = false;
            pnlSelect.Visible = true;
            // Reset page size to show all when switching tabs
            ddlPageSize.SelectedValue = "all";
            currentPageSize = 0;
            Response.Redirect($"AdminCandidatesView.aspx?tab={currentTab}");
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            currentSearch = txtSearch.Text.Trim();
            selectedCandidateId = 0;
            pnlDetails.Visible = false;
            pnlSelect.Visible = true;
            BindCandidates();
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (selectedCandidateId > 0)
            {
                string newStatus = ddlStatus.SelectedValue;
                UpdateCandidateStatus(selectedCandidateId, newStatus);
                // Refresh the entire page to reflect changes
                Response.Redirect($"AdminCandidatesView.aspx?id={selectedCandidateId}&tab={currentTab}");
            }
        }

        // ============================================
        // PAGE SIZE DROPDOWN EVENT HANDLER
        // ============================================
        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlPageSize.SelectedValue;
            if (selectedValue == "all")
            {
                currentPageSize = 0;
            }
            else
            {
                currentPageSize = int.Parse(selectedValue);
            }

            // IMPORTANT: Preserve the current tab from ViewState
            if (ViewState["CurrentTab"] != null)
            {
                currentTab = ViewState["CurrentTab"].ToString();
            }
            else
            {
                string tab = Request.QueryString["tab"];
                if (!string.IsNullOrEmpty(tab))
                {
                    currentTab = tab;
                }
            }

            selectedCandidateId = 0;
            pnlDetails.Visible = false;
            pnlSelect.Visible = true;

            // Rebind with the current tab filter applied
            BindCandidates();
            UpdateTabStyles();
        }

        private void UpdateCandidateStatus(int candidateId, string newStatus)
        {
            try
            {
                // First ensure the table exists with proper columns
                EnsureJobApplicationTableExists();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Check if record exists for this user
                    string checkRecordQuery = "SELECT COUNT(*) FROM JobApplication WHERE UserId = @UserId";
                    using (SqlCommand checkRecordCmd = new SqlCommand(checkRecordQuery, con))
                    {
                        checkRecordCmd.Parameters.AddWithValue("@UserId", candidateId);
                        int count = Convert.ToInt32(checkRecordCmd.ExecuteScalar());

                        if (count > 0)
                        {
                            // Update existing record
                            string updateQuery = "UPDATE JobApplication SET Status = @Status, UpdatedDate = GETDATE() WHERE UserId = @UserId";
                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                            {
                                updateCmd.Parameters.AddWithValue("@Status", newStatus);
                                updateCmd.Parameters.AddWithValue("@UserId", candidateId);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            // Insert new record
                            string insertQuery = "INSERT INTO JobApplication (UserId, Status, UpdatedDate) VALUES (@UserId, @Status, GETDATE())";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                            {
                                insertCmd.Parameters.AddWithValue("@UserId", candidateId);
                                insertCmd.Parameters.AddWithValue("@Status", newStatus);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error or handle appropriately
                System.Diagnostics.Debug.WriteLine("Error updating candidate status: " + ex.Message);
            }
        }
    }
}