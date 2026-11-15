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
            // Nothing to do here
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

                            // Show success message
                            lblMessage.ForeColor = System.Drawing.Color.Green;
                            lblMessage.Text = "Account created successfully. Redirecting to login...";

                            // Redirect after 2 seconds
                            string script = "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 2000);";
                            ClientScript.RegisterStartupScript(this.GetType(), "RedirectToLogin", script, true);
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