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
            // If already logged in, redirect based on role
            if (Session["UserID"] != null)
            {
                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                {
                    Response.Redirect("AdminDashboard.aspx");
                }
                else
                {
                    Response.Redirect("Personal.aspx");
                }
            }
        }

        protected void Login_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Please enter email and password.";
                return;
            }

            string query = @"SELECT id, email, password, Role
                 FROM Users
                 WHERE email = @Email
                 AND password = @Password";

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

                    // Store in session
                    Session["UserID"] = userId;
                    Session["UserRole"] = role;

                    // Redirect based on role
                    if (role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Personal.aspx");
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                }

                dr.Close();
            }
        }
    }
}