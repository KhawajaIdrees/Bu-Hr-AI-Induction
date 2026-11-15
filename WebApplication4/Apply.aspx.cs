using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication4
{
    public partial class Apply : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadJobDetails();
            }
        }

        private void LoadJobDetails()
        {
            int jobId;
            if (!int.TryParse(Request.QueryString["jobId"], out jobId))
            {
                ShowError("Invalid or missing job reference. Please return to the Open Positions page.");
                return;
            }

            string query = @"
                SELECT JobPostingID, JobTitle, ReferenceNo, Campus, Department,
                       Specialization, JobType, HiringType, DeadlineDate
                FROM JobPostings
                WHERE JobPostingID = @JobId";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobId", jobId);
                con.Open();

                using (SqlDataReader r = cmd.ExecuteReader())
                {
                    if (r.Read())
                    {
                        DateTime deadline = Convert.ToDateTime(r["DeadlineDate"]);
                        if (deadline.Date < DateTime.Today)
                        {
                            ShowError("The application deadline for this position has passed.");
                            return;
                        }

                        lblJobTitle.Text = r["JobTitle"].ToString();
                        lblReferenceNo.Text = r["ReferenceNo"].ToString();
                        lblCampus.Text = r["Campus"].ToString();
                        lblDepartment.Text = r["Department"].ToString();
                        lblSpecialization.Text = r["Specialization"].ToString();
                        lblJobType.Text = r["JobType"].ToString();
                        lblDeadline.Text = deadline.ToString("MMM dd, yyyy");

                        ViewState["JobPostingID"] = jobId;
                        pnlContent.Visible = true;
                    }
                    else
                    {
                        ShowError("The requested job posting could not be found.");
                    }
                }
            }
        }

        protected void ApplyManual_Click(object sender, EventArgs e)
        {
            StartApplication();
        }

        protected void ApplyCV_Click(object sender, EventArgs e)
        {
            // For now, both buttons do the same thing.
            // CV upload will be added later.
            StartApplication();
        }

        private void StartApplication()
        {
            if (ViewState["JobPostingID"] == null)
            {
                ShowError("Job information missing. Please return to Open Positions.");
                return;
            }

            int jobId = Convert.ToInt32(ViewState["JobPostingID"]);

            // Remember the job the user is applying for across the login + profile flow
            Session["PendingJobId"] = jobId;

            // If already logged in as Candidate, jump straight to the profile flow.
            // Otherwise, send them to Login.
            if (Session["UserID"] != null)
            {
                string role = Session["UserRole"] != null ? Session["UserRole"].ToString() : "";
                if (role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                {
                    ShowError("Administrators cannot apply for jobs. Please log in with a candidate account.");
                    return;
                }
                Response.Redirect("Personal.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            pnlError.Visible = true;
            pnlContent.Visible = false;
        }
    }
}