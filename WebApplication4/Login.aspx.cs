using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["UserID"] != null)
            {
                RedirectAfterLogin();
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter email and password.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string query = @"SELECT id, email, password, Role
                             FROM Users
                             WHERE email = @Email AND password = @Password";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    string userId = dr["id"].ToString();
                    string role = dr["Role"].ToString();

                    Session["UserID"] = userId;
                    Session["UserRole"] = role;

                    dr.Close();
                    RedirectAfterLogin();
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    dr.Close();
                }
            }
        }

        // Redirects based on role, but respects a pending job application
        private void RedirectAfterLogin()
        {
            string role = Session["UserRole"] != null ? Session["UserRole"].ToString() : "";

            if (role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("AdminDashboard.aspx");
                return;
            }

            // If there's a pending job application, continue the normal profile flow.
            // ApplicationSummary will insert the JobApplication row at the end.
            if (Session["PendingJobId"] != null)
            {
                Response.Redirect("Personal.aspx");
                return;
            }

            Response.Redirect("Personal.aspx");
        }
    }
}