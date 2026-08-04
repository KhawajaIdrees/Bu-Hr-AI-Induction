using System;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class CreateJob : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            pnlMessage.Visible = true;
            pnlMessage.Style["display"] = "block";

            // Check required fields
            if (string.IsNullOrWhiteSpace(txtJobTitle.Text) ||
                string.IsNullOrWhiteSpace(txtJobID.Text) ||
                string.IsNullOrWhiteSpace(txtReferenceNo.Text) ||
                string.IsNullOrWhiteSpace(txtCampus.Text) ||
                string.IsNullOrWhiteSpace(ddlJobType.SelectedValue) ||
                string.IsNullOrWhiteSpace(txtPublishedDate.Text) ||
                string.IsNullOrWhiteSpace(txtDeadlineDate.Text))
            {
                ShowError("Fill all missing fields.");
                return;
            }

            DateTime publishedDate;
            DateTime deadlineDate;

            // Parse dates
            if (!DateTime.TryParse(txtPublishedDate.Text, out publishedDate))
            {
                ShowError("Invalid Published Date.");
                return;
            }

            if (!DateTime.TryParse(txtDeadlineDate.Text, out deadlineDate))
            {
                ShowError("Invalid Deadline Date.");
                return;
            }

            // Deadline validation
            if (deadlineDate.Date < publishedDate.Date)
            {
                ShowError("Deadline date cannot be before Published Date.");
                return;
            }

            // Success
            ShowSuccess("Job Created Successfully.");
            Response.Redirect("~/AdminDashboard.aspx");

            // Clear form
            txtJobTitle.Text = "";
            txtJobID.Text = "";
            txtReferenceNo.Text = "";
            txtCampus.Text = "";
            ddlJobType.SelectedIndex = 0;
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