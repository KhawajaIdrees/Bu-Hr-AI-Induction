using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class AdminProfile : Page
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
                LoadAdminProfile();
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

        private void LoadAdminProfile()
        {
            try
            {
                string query = @"
                    SELECT Id, UserId, Email, FullName, Phone, ProfileImage, Role, LastLogin
                    FROM Admins
                    WHERE UserId = @UserId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string fullName = reader["FullName"]?.ToString() ?? "";

                            if (string.IsNullOrEmpty(fullName))
                            {
                                fullName = "System Administrator";
                            }

                            txtFullName.Text = fullName;
                            txtEmail.Text = reader["Email"]?.ToString() ?? "";
                            txtPhone.Text = reader["Phone"]?.ToString() ?? "";
                            txtRole.Text = reader["Role"]?.ToString() ?? "Administrator";

                            string profileImage = reader["ProfileImage"]?.ToString();
                            if (!string.IsNullOrEmpty(profileImage))
                            {
                                imgProfile.ImageUrl = profileImage;
                            }
                            else
                            {
                                SetDefaultProfileImage();
                            }

                            lblAdminInitial.Text = "A";
                            lblAdminName.Text = fullName;
                        }
                        else
                        {
                            // Create admin record
                            CreateAdminRecord();
                            LoadAdminProfile(); // Reload after creating
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading profile: " + ex.Message);
                SetDefaultProfile();
            }
        }

        private void CreateAdminRecord()
        {
            try
            {
                string email = GetUserEmail();
                string insertQuery = @"
                    INSERT INTO Admins (UserId, Email, FullName, Role, CreatedDate, IsActive)
                    VALUES (@UserId, @Email, 'System Administrator', 'Admin', GETDATE(), 1)";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                {
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error creating admin record: " + ex.Message);
            }
        }

        private void SetDefaultProfile()
        {
            txtFullName.Text = "System Administrator";
            txtEmail.Text = GetUserEmail();
            txtPhone.Text = "";
            txtRole.Text = "Administrator";
            SetDefaultProfileImage();
            lblAdminName.Text = "System Administrator";
            lblAdminInitial.Text = "A";
        }

        private string GetUserEmail()
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
                    return result?.ToString() ?? "";
                }
            }
            catch
            {
                return "";
            }
        }

        private void SetDefaultProfileImage()
        {
            string imagePath = $"~/Images/Admin_{CurrentUserId}.jpg";
            string physicalPath = Server.MapPath(imagePath);
            if (File.Exists(physicalPath))
            {
                imgProfile.ImageUrl = imagePath;
                return;
            }

            imagePath = $"~/Images/Admin_{CurrentUserId}.png";
            physicalPath = Server.MapPath(imagePath);
            if (File.Exists(physicalPath))
            {
                imgProfile.ImageUrl = imagePath;
                return;
            }

            imagePath = $"~/Images/Profile_{CurrentUserId}.jpg";
            physicalPath = Server.MapPath(imagePath);
            if (File.Exists(physicalPath))
            {
                imgProfile.ImageUrl = imagePath;
                return;
            }

            imagePath = $"~/Images/Profile_{CurrentUserId}.png";
            physicalPath = Server.MapPath(imagePath);
            if (File.Exists(physicalPath))
            {
                imgProfile.ImageUrl = imagePath;
                return;
            }

            imgProfile.ImageUrl = "~/Images/default-avatar.png";
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

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            ClearMessages();

            try
            {
                string fullName = txtFullName.Text.Trim();
                string phone = txtPhone.Text.Trim();

                if (string.IsNullOrEmpty(fullName))
                {
                    ShowError("Full name is required.");
                    return;
                }

                // Update the Admin record
                string updateQuery = @"
                    UPDATE Admins 
                    SET FullName = @FullName,
                        Phone = @Phone
                    WHERE UserId = @UserId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(phone) ? "" : phone);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        // If no rows updated, try inserting
                        string email = GetUserEmail();
                        string insertQuery = @"
                            INSERT INTO Admins (UserId, Email, FullName, Phone, Role, CreatedDate, IsActive)
                            VALUES (@UserId, @Email, @FullName, @Phone, 'Admin', GETDATE(), 1)";

                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                        {
                            insertCmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                            insertCmd.Parameters.AddWithValue("@Email", email);
                            insertCmd.Parameters.AddWithValue("@FullName", fullName);
                            insertCmd.Parameters.AddWithValue("@Phone", string.IsNullOrEmpty(phone) ? "" : phone);
                            insertCmd.ExecuteNonQuery();
                        }
                    }
                }

                // Update the header immediately
                lblAdminName.Text = fullName;
                lblAdminInitial.Text = "A";

                ShowMessage($"Profile updated successfully! Name changed to: {fullName}");

                // Reload the profile data to refresh all fields
                LoadAdminProfile();

                // Force a full page refresh
                Response.Redirect(Request.RawUrl);
            }
            catch (Exception ex)
            {
                ShowError("Error updating profile: " + ex.Message);
            }
        }

        protected void btnUploadImage_Click(object sender, EventArgs e)
        {
            ClearMessages();

            try
            {
                if (!fuProfileImage.HasFile)
                {
                    ShowError("Please select an image file to upload.");
                    return;
                }

                string extension = Path.GetExtension(fuProfileImage.FileName).ToLower();
                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
                {
                    ShowError("Only JPG and PNG files are allowed.");
                    return;
                }

                if (fuProfileImage.PostedFile.ContentLength > 2 * 1024 * 1024)
                {
                    ShowError("File size must be less than 2MB.");
                    return;
                }

                string folderPath = Server.MapPath("~/Images");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = $"Admin_{CurrentUserId}{extension}";
                string savePath = Path.Combine(folderPath, fileName);
                fuProfileImage.SaveAs(savePath);

                string photoPath = $"~/Images/{fileName}";

                string updateQuery = @"
                    UPDATE Admins 
                    SET ProfileImage = @ProfileImage
                    WHERE UserId = @UserId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@ProfileImage", photoPath);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                imgProfile.ImageUrl = photoPath + "?t=" + DateTime.Now.Ticks;
                ShowMessage("Profile picture updated successfully!");
                LoadAdminProfile();
            }
            catch (Exception ex)
            {
                ShowError("Error uploading image: " + ex.Message);
            }
        }
    }
}