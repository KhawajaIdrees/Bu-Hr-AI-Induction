using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class NonCreateJob : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No default dates set - user must enter them
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            pnlMessage.Visible = true;
            pnlMessage.Style["display"] = "block";

            // Check required fields (ALL fields except Job Type)
            if (string.IsNullOrWhiteSpace(txtJobTitle.Text) ||
                string.IsNullOrWhiteSpace(txtJobID.Text) ||
                string.IsNullOrWhiteSpace(txtReferenceNo.Text) ||
                string.IsNullOrWhiteSpace(txtCampus.Text) ||
                string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                string.IsNullOrWhiteSpace(txtSpecialization.Text) ||
                string.IsNullOrWhiteSpace(ddlEducation.SelectedValue) ||
                string.IsNullOrWhiteSpace(ddlExperience.SelectedValue) ||
                string.IsNullOrWhiteSpace(txtPublishedDate.Text) ||
                string.IsNullOrWhiteSpace(txtDeadlineDate.Text))
            {
                ShowError("Please fill all required fields.");
                return;
            }

            DateTime publishedDate;
            DateTime deadlineDate;

            // Parse dates
            if (!DateTime.TryParse(txtPublishedDate.Text, out publishedDate))
            {
                ShowError("Invalid Published Date. Please use MM/DD/YYYY format.");
                return;
            }

            if (!DateTime.TryParse(txtDeadlineDate.Text, out deadlineDate))
            {
                ShowError("Invalid Deadline Date. Please use MM/DD/YYYY format.");
                return;
            }

            // Deadline validation
            if (deadlineDate.Date < publishedDate.Date)
            {
                ShowError("Deadline date cannot be before Published Date.");
                return;
            }

            try
            {
                // Save to database
                SaveJobToDatabase();

                ShowSuccess("Non-Teaching Job Created Successfully!");

                // Clear form
                ClearForm();

                // Redirect after 2 seconds
                ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                    "setTimeout(function(){ window.location.href = 'AdminDashboard.aspx'; }, 2000);", true);
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        private void SaveJobToDatabase()
        {
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"INSERT INTO JobPostings 
                            (JobTitle, JobID, ReferenceNo, Campus, Department, Specialization, 
                             EducationRequired, ExperienceRequired, JobType, PublishedDate, DeadlineDate, CreatedAt) 
                            VALUES 
                            (@JobTitle, @JobID, @ReferenceNo, @Campus, @Department, @Specialization,
                             @EducationRequired, @ExperienceRequired, @JobType, @PublishedDate, @DeadlineDate, GETDATE())";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@JobTitle", txtJobTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@JobID", txtJobID.Text.Trim());
                cmd.Parameters.AddWithValue("@ReferenceNo", txtReferenceNo.Text.Trim());
                cmd.Parameters.AddWithValue("@Campus", txtCampus.Text.Trim());
                cmd.Parameters.AddWithValue("@Department", txtDepartment.Text.Trim());
                cmd.Parameters.AddWithValue("@Specialization", txtSpecialization.Text.Trim());
                cmd.Parameters.AddWithValue("@EducationRequired", ddlEducation.SelectedValue);
                cmd.Parameters.AddWithValue("@ExperienceRequired", ddlExperience.SelectedValue);
                cmd.Parameters.AddWithValue("@JobType", "NonTeaching");
                cmd.Parameters.AddWithValue("@PublishedDate", Convert.ToDateTime(txtPublishedDate.Text));
                cmd.Parameters.AddWithValue("@DeadlineDate", Convert.ToDateTime(txtDeadlineDate.Text));

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void ClearForm()
        {
            txtJobTitle.Text = "";
            txtJobID.Text = "";
            txtReferenceNo.Text = "";
            txtCampus.Text = "";
            txtDepartment.Text = "";
            txtSpecialization.Text = "";
            ddlEducation.SelectedIndex = 0;
            ddlExperience.SelectedIndex = 0;
            txtPublishedDate.Text = "";
            txtDeadlineDate.Text = "";
        }

        private void ShowError(string message)
        {
            pnlMessage.Visible = true;
            pnlMessage.BackColor = Color.MistyRose;
            pnlMessage.BorderStyle = BorderStyle.Solid;
            pnlMessage.BorderWidth = Unit.Pixel(1);
            pnlMessage.BorderColor = Color.Red;

            lblMessage.ForeColor = Color.DarkRed;
            lblMessage.Text = message;
        }

        private void ShowSuccess(string message)
        {
            pnlMessage.Visible = true;
            pnlMessage.BackColor = Color.Honeydew;
            pnlMessage.BorderStyle = BorderStyle.Solid;
            pnlMessage.BorderWidth = Unit.Pixel(1);
            pnlMessage.BorderColor = Color.Green;

            lblMessage.ForeColor = Color.DarkGreen;
            lblMessage.Text = message;
        }
    }
}