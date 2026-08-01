using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication4
{
    public partial class ExperiencePhd : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadExperiences();
            }
        }

        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            int userId = Convert.ToInt32(Session["UserID"]);

            string organization = txtOrganization.Text.Trim();
            string position = txtPosition.Text.Trim();

            // Fixed: Use TryParse for safe date conversion
            DateTime startDate;
            if (!DateTime.TryParse(txtStartDate.Text, out startDate))
            {
                lblMessage.Text = "Please enter a valid Start Date.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            DateTime? endDate = null;
            if (!chkCurrentJob.Checked && !string.IsNullOrWhiteSpace(txtEndDate.Text))
            {
                DateTime endDateTemp;
                if (DateTime.TryParse(txtEndDate.Text, out endDateTemp))
                {
                    endDate = endDateTemp;
                }
                else
                {
                    lblMessage.Text = "Please enter a valid End Date.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }

            bool currentJob = chkCurrentJob.Checked;

            SaveExperience(userId,
                           organization,
                           position,
                           startDate,
                           endDate,
                           currentJob);

            ClearForm();
            LoadExperiences();

            lblMessage.Text = "Experience added successfully.";
            lblMessage.CssClass = "text-success";
        }

        private void SaveExperience(int userId,
                                    string organization,
                                    string position,
                                    DateTime startDate,
                                    DateTime? endDate,
                                    bool currentJob)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO WorkExperience
                                (UserId,
                                 OrganizationName,
                                 PositionTitle,
                                 StartDate,
                                 EndDate,
                                 IsCurrentJob)
                                VALUES
                                (@UserId,
                                 @OrganizationName,
                                 @PositionTitle,
                                 @StartDate,
                                 @EndDate,
                                 @IsCurrentJob)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@OrganizationName", organization);
                cmd.Parameters.AddWithValue("@PositionTitle", position);
                cmd.Parameters.AddWithValue("@StartDate", startDate);

                if (endDate.HasValue)
                    cmd.Parameters.AddWithValue("@EndDate", endDate.Value);
                else
                    cmd.Parameters.AddWithValue("@EndDate", DBNull.Value);

                cmd.Parameters.AddWithValue("@IsCurrentJob", currentJob);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void LoadExperiences()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT
                        ExperienceId,
                        OrganizationName,
                        PositionTitle,
                        StartDate,
                        CASE
                            WHEN IsCurrentJob = 1 THEN NULL
                            ELSE EndDate
                        END AS EndDate,
                        CONCAT(
                            DATEDIFF(MONTH,
                                     StartDate,
                                     ISNULL(EndDate, GETDATE())) / 12,
                            ' Years ',
                            DATEDIFF(MONTH,
                                     StartDate,
                                     ISNULL(EndDate, GETDATE())) % 12,
                            ' Months'
                        ) AS Duration
                    FROM WorkExperience
                    WHERE UserId=@UserId
                    ORDER BY StartDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserId", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvExperiences.DataSource = dt;
                gvExperiences.DataBind();
            }
        }

        // =========================================
        // DELETE EXPERIENCE
        // =========================================
        protected void gvExperiences_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteExperience")
            {
                // CommandArgument is the row index; use DataKeys to get the true ExperienceId
                int rowIndex;
                if (int.TryParse(e.CommandArgument.ToString(), out rowIndex))
                {
                    if (rowIndex >= 0 && rowIndex < gvExperiences.Rows.Count)
                    {
                        object key = gvExperiences.DataKeys[rowIndex]?.Value;
                        if (key != null)
                        {
                            int experienceId = Convert.ToInt32(key);
                            DeleteExperience(experienceId);
                        }
                        else
                        {
                            lblMessage.Text = "Unable to determine which experience to delete.";
                            lblMessage.CssClass = "text-danger";
                            return;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Invalid selection.";
                        lblMessage.CssClass = "text-danger";
                        return;
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid command argument.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
                LoadExperiences();
                lblMessage.Text = "Experience deleted successfully.";
                lblMessage.CssClass = "text-success";
            }
        }

        private void DeleteExperience(int experienceId)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"DELETE FROM WorkExperience 
                                WHERE ExperienceId = @ExperienceId 
                                AND UserId = @UserId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ExperienceId", experienceId);
                cmd.Parameters.AddWithValue("@UserId", userId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void ClearForm()
        {
            txtOrganization.Text = "";
            txtPosition.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            chkCurrentJob.Checked = false;
        }

        protected void BtnNext_Click(object sender, EventArgs e)
        {
            // Check if user has at least one experience
            int userId = Convert.ToInt32(Session["UserID"]);
            int count = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM WorkExperience WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", userId);
                con.Open();
                count = (int)cmd.ExecuteScalar();
            }

            if (count == 0)
            {
                lblMessage.Text = "Please add at least one work experience before continuing.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            Response.Redirect("ResearchData.aspx");
        }
    }
}