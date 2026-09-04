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
                string query = "SELECT FullName FROM Admins WHERE UserId = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        string fullName = result.ToString();
                        if (string.IsNullOrEmpty(fullName))
                            fullName = "System Administrator";
                        lblAdminName.Text = fullName;
                    }
                    else
                    {
                        lblAdminName.Text = "System Administrator";
                    }
                    lblAdminInitial.Text = "A";
                }
            }
            catch
            {
                lblAdminName.Text = "System Administrator";
                lblAdminInitial.Text = "A";
            }
        }

        private void LoadCurrentEmail()
        {
            try
            {
                string query = "SELECT Email FROM Admins WHERE UserId = @UserId";
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
                    else
                    {
                        string fallbackQuery = "SELECT email FROM Users WHERE id = @UserId";
                        using (SqlCommand fallbackCmd = new SqlCommand(fallbackQuery, con))
                        {
                            fallbackCmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                            object fallbackResult = fallbackCmd.ExecuteScalar();
                            if (fallbackResult != null)
                                txtCurrentEmail.Text = fallbackResult.ToString();
                        }
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
                string query = "SELECT LastLogin FROM Admins WHERE UserId = @UserId";
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

                string checkQuery = "SELECT COUNT(*) FROM Admins WHERE Email = @Email AND UserId != @UserId";
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

                string updateQuery = "UPDATE Admins SET Email = @Email WHERE UserId = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Email", newEmail);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                string updateUsersQuery = "UPDATE Users SET email = @Email WHERE id = @UserId";
                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateUsersQuery, con))
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