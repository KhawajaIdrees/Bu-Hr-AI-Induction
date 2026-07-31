using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class PreviousEmployment : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidate();
            }
        }

        // Load existing candidate data
        private void LoadCandidate()
        {
            if (Session["UserId"] == null)
                return;

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT hasworked,
                       campus,
                       dept,
                       designation,
                       duration
                FROM PrevEmpl
                WHERE userId = @userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool hasWorked =
                                dr["hasworked"] != DBNull.Value &&
                                Convert.ToBoolean(dr["hasworked"]);

                            if (hasWorked)
                            {
                                rblPreviouslyWorked.SelectedValue = "Yes";

                                string campus = dr["campus"].ToString();

                                if (ddlCampus.Items.FindByValue(campus) != null)
                                {
                                    ddlCampus.SelectedValue = campus;
                                }
                                else
                                {
                                    ddlCampus.SelectedIndex = 0;
                                }

                                txtDepartment.Text = dr["dept"].ToString();
                                txtDesignation.Text = dr["designation"].ToString();
                                txtDuration.Text = dr["duration"].ToString();
                            }
                            else
                            {
                                rblPreviouslyWorked.SelectedValue = "No";
                                ClearFields();
                            }
                        }
                        else
                        {
                            // No record found
                            rblPreviouslyWorked.SelectedValue = "No";
                            ClearFields();
                        }
                    }
                }
            }

            // NOTE: pnlPreviousEmploymentWrapper.Visible is intentionally NOT set here.
            // It must always render to the DOM so the client-side
            // togglePreviousEmploymentDetails() script can find and show/hide it.
            // Do not reintroduce Visible = true/false on this control.
        }

        // Insert or Update record
        private void SavePrevEmpl(int userId)
        {
            bool hasWorked = rblPreviouslyWorked.SelectedValue == "Yes";

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                IF EXISTS (SELECT 1 FROM PrevEmpl WHERE userId = @userId)
                BEGIN
                    UPDATE PrevEmpl
                    SET hasworked   = @hasworked,
                        campus      = @campus,
                        dept        = @dept,
                        designation = @designation,
                        duration    = @duration,
                        updatedDate = GETDATE()
                    WHERE userId = @userId
                END
                ELSE
                BEGIN
                    INSERT INTO PrevEmpl
                        (userId, hasworked, campus, dept, designation, duration)
                    VALUES
                        (@userId, @hasworked, @campus, @dept, @designation, @duration)
                END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    cmd.Parameters.Add("@hasworked", SqlDbType.Bit).Value = hasWorked;

                    if (hasWorked)
                    {
                        cmd.Parameters.Add("@campus", SqlDbType.VarChar, 100).Value = ddlCampus.SelectedValue;
                        cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value = txtDepartment.Text.Trim();
                        cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value = txtDesignation.Text.Trim();
                        cmd.Parameters.Add("@duration", SqlDbType.VarChar, 100).Value = txtDuration.Text.Trim();
                    }
                    else
                    {
                        cmd.Parameters.Add("@campus", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@duration", SqlDbType.VarChar, 100).Value = DBNull.Value;
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ClearFields()
        {
            ddlCampus.SelectedIndex = 0;
            txtDepartment.Text = "";
            txtDesignation.Text = "";
            txtDuration.Text = "";
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                return;
            if (rblPreviouslyWorked.SelectedItem == null)
            {
                lblMessage.Text = "Please select Yes or No.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            // If user selected No, allow save and continue without filling details
            if (rblPreviouslyWorked.SelectedValue == "No")
            {
                try
                {
                    // Save will insert/update with hasworked = 0 and NULL details
                    SavePrevEmpl(userId);

                    lblMessage.Text = "Previous employment declaration saved successfully.";
                    lblMessage.CssClass = "text-success";

                    LoadCandidate();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                Response.Redirect("EmpRelDeclaration.aspx");
                return;
            }

            // From here on user selected Yes. Ensure validators passed
            if (!Page.IsValid)
                return;

            try
            {
                SavePrevEmpl(userId);

                lblMessage.Text = "Previous employment declaration saved successfully.";
                lblMessage.CssClass = "text-success";

                LoadCandidate();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }

            Response.Redirect("EmpRelDeclaration.aspx");
        }
    }
}
