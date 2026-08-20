using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class AdminSettings : Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        private int CurrentUserId
        {
            get
            {
                if (Session["UserID"] == null)
                    return 0;
                return Convert.ToInt32(Session["UserID"]);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if user is Admin
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAdminInfo();
                LoadLastLogin();
                LoadCurrentEmail();
            }
        }

        // ============================================
        // LOGOUT METHOD
        // ============================================
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        private void LoadAdminInfo()
        {
            try
            {
                string query = @"
                    SELECT p.fname, p.lname
                    FROM Users u
                    LEFT JOIN Personal p ON u.id = p.userId
                    WHERE u.id = @UserId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName = reader["fname"]?.ToString() ?? "";
                            string lastName = reader["lname"]?.ToString() ?? "";
                            string fullName = (firstName + " " + lastName).Trim();

                            if (string.IsNullOrEmpty(fullName))
                            {
                                fullName = "Administrator";
                            }

                            lblAdminName.Text = fullName;

                            if (!string.IsNullOrEmpty(fullName))
                            {
                                string[] parts = fullName.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                                if (parts.Length >= 2)
                                {
                                    lblAdminInitial.Text = (parts[0][0] + parts[parts.Length - 1][0]).ToString().ToUpper();
                                }
                                else if (parts.Length == 1 && parts[0].Length > 0)
                                {
                                    lblAdminInitial.Text = parts[0][0].ToString().ToUpper();
                                }
                                else
                                {
                                    lblAdminInitial.Text = "A";
                                }
                            }
                            else
                            {
                                lblAdminInitial.Text = "A";
                            }
                        }
                    }
                }
            }
            catch
            {
                // Silent fail
            }
        }

        private void LoadCurrentEmail()
        {
            try
            {
                string query = "SELECT email FROM Users WHERE id = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        txtCurrentEmail.Text = result.ToString();
                    }
                }
            }
            catch
            {
                txtCurrentEmail.Text = "N/A";
            }
        }

        private void LoadLastLogin()
        {
            try
            {
                // Ensure AdminUsers table exists
                string createTableQuery = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
                    BEGIN
                        CREATE TABLE AdminUsers (
                            Id INT IDENTITY(1,1) PRIMARY KEY,
                            UserId INT NOT NULL,
                            Role NVARCHAR(50) DEFAULT 'Admin',
                            LastLogin DATETIME,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            IsActive BIT DEFAULT 1
                        )
                    END
                    ELSE
                    BEGIN
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('AdminUsers') AND name = 'LastLogin')
                        BEGIN
                            ALTER TABLE AdminUsers ADD LastLogin DATETIME
                        END
                    END";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(createTableQuery, con))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }

                string query = "SELECT LastLogin FROM AdminUsers WHERE UserId = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        txtLastLogin.Text = Convert.ToDateTime(result).ToString("dd MMM yyyy HH:mm");
                    }
                    else
                    {
                        txtLastLogin.Text = "First login";
                    }
                }
            }
            catch
            {
                txtLastLogin.Text = "N/A";
            }
        }

        private void ShowMessage(string message)
        {
            pnlMessage.Visible = true;
            pnlError.Visible = false;
            lblMessage.Text = message;
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            pnlMessage.Visible = false;
            lblError.Text = message;
        }

        private void ClearMessages()
        {
            pnlMessage.Visible = false;
            pnlError.Visible = false;
        }

        // ============================================
        // CHANGE EMAIL
        // ============================================
        protected void btnChangeEmail_Click(object sender, EventArgs e)
        {
            ClearMessages();

            try
            {
                string newEmail = txtNewEmail.Text.Trim();
                string confirmEmail = txtConfirmEmail.Text.Trim();

                if (string.IsNullOrEmpty(newEmail))
                {
                    ShowError("New email is required.");
                    return;
                }

                if (newEmail != confirmEmail)
                {
                    ShowError("New email and confirm email do not match.");
                    return;
                }

                // Check if email already exists for another user
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE email = @Email AND id != @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(checkQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Email", newEmail);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count > 0)
                    {
                        ShowError("This email is already in use by another account.");
                        return;
                    }
                }

                // Update email
                string updateQuery = "UPDATE Users SET email = @Email WHERE id = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Email", newEmail);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                txtCurrentEmail.Text = newEmail;
                txtNewEmail.Text = "";
                txtConfirmEmail.Text = "";

                ShowMessage("Email changed successfully!");
            }
            catch (Exception ex)
            {
                ShowError("Error changing email: " + ex.Message);
            }
        }

        // ============================================
        // CHANGE PASSWORD
        // ============================================
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            ClearMessages();

            try
            {
                string currentPassword = txtCurrentPassword.Text;
                string newPassword = txtNewPassword.Text;
                string confirmPassword = txtConfirmPassword.Text;

                if (string.IsNullOrEmpty(currentPassword) || string.IsNullOrEmpty(newPassword))
                {
                    ShowError("Current password and new password are required.");
                    return;
                }

                if (newPassword.Length < 6)
                {
                    ShowError("New password must be at least 6 characters long.");
                    return;
                }

                if (newPassword != confirmPassword)
                {
                    ShowError("New password and confirm password do not match.");
                    return;
                }

                // Verify current password
                string verifyQuery = "SELECT password FROM Users WHERE id = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(verifyQuery, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    if (result == null || result.ToString() != currentPassword)
                    {
                        ShowError("Current password is incorrect.");
                        return;
                    }
                }

                // Update password
                string updateQuery = "UPDATE Users SET password = @Password WHERE id = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Password", newPassword);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";

                ShowMessage("Password changed successfully!");
            }
            catch (Exception ex)
            {
                ShowError("Error changing password: " + ex.Message);
            }
        }
    }
}