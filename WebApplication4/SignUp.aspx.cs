using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear any existing session when on signup page
            if (!IsPostBack)
            {
                // Optional: Clear session to prevent auto-login issues
                // Session.Clear();
                // Session.Abandon();
            }
        }

        protected void InsertUser(string email, string password)
        {
            string role = "Candidate";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Check if email already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE email = @email";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@email", email);

                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Email already exists.";
                        return;
                    }
                    else
                    {
                        string insertQuery = @"INSERT INTO Users (email, password, role)
                               VALUES (@email, @password, @role);
                               SELECT SCOPE_IDENTITY();";

                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                        {
                            insertCmd.Parameters.AddWithValue("@email", email);
                            insertCmd.Parameters.AddWithValue("@password", password);
                            insertCmd.Parameters.AddWithValue("@role", role);

                            int userId = Convert.ToInt32(insertCmd.ExecuteScalar());

                            // ❌ REMOVE THIS LINE - Don't set session on registration
                            // Session["UserID"] = userId;

                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "✅ Registration successful! Redirecting to Login...";

                            // ✅ Redirect to Login page after successful registration
                            Response.Redirect("Login.aspx");
                        }
                    }
                }
            }
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            // Validate page first
            if (Page.IsValid)
            {
                string email = txtEmail.Text;
                string password = txtPassword.Text;
                InsertUser(email, password);
            }
        }
    }
}