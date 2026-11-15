using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class JobApps : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOpenJobs();
            }
        }

        private void LoadOpenJobs()
        {
            // Only show jobs whose deadline has not passed.
            // Also flag whether the current user already applied.
            int? currentUserId = Session["UserID"] != null
                ? (int?)Convert.ToInt32(Session["UserID"])
                : null;

            string query = @"
                SELECT 
                    p.JobPostingID,
                    p.JobTitle,
                    p.ReferenceNo,
                    p.Campus,
                    p.Department,
                    p.Specialization,
                    p.JobType,
                    p.HiringType,
                    p.DeadlineDate,
                    CASE WHEN @UserId IS NULL THEN 0
                         WHEN EXISTS (
                            SELECT 1 FROM JobApplication ja 
                            WHERE ja.JobPostingID = p.JobPostingID 
                              AND ja.UserId = @UserId
                         ) THEN 1
                         ELSE 0
                    END AS HasApplied
                FROM JobPostings p
                WHERE CAST(p.DeadlineDate AS DATE) >= CAST(GETDATE() AS DATE)
                ORDER BY p.PublishedDate DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (currentUserId.HasValue)
                    cmd.Parameters.AddWithValue("@UserId", currentUserId.Value);
                else
                    cmd.Parameters.AddWithValue("@UserId", DBNull.Value);

                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Convert HasApplied from INT to BOOL for the markup
                    dt.Columns.Add("HasAppliedBool", typeof(bool));
                    foreach (DataRow row in dt.Rows)
                    {
                        row["HasAppliedBool"] = Convert.ToInt32(row["HasApplied"]) == 1;
                    }
                    dt.Columns.Remove("HasApplied");
                    dt.Columns["HasAppliedBool"].ColumnName = "HasApplied";

                    gvJobs.DataSource = dt;
                    gvJobs.DataBind();
                }
            }
        }

        protected void gvJobs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApplyJob")
            {
                int jobId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("Apply.aspx?jobId=" + jobId);
            }
        }
    }
}