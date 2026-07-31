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

            DateTime startDate = Convert.ToDateTime(txtStartDate.Text);

            DateTime? endDate = null;

            if (!chkCurrentJob.Checked && !string.IsNullOrWhiteSpace(txtEndDate.Text))
            {
                endDate = Convert.ToDateTime(txtEndDate.Text);
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
            Response.Redirect("ResearchData.aspx");
        }
    }
}