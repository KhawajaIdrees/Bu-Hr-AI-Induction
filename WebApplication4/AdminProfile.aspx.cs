using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
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
                LoadUserProfile();
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

        private void LoadUserProfile()
        {
            try
            {
                string query = @"
                    SELECT u.id, u.email, 
                           p.fname, p.lname, p.cellNumber, p.PhotoPath
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
                            // Handle NULL values safely
                            string firstName = reader["fname"]?.ToString() ?? "";
                            string lastName = reader["lname"]?.ToString() ?? "";
                            string fullName = (firstName + " " + lastName).Trim();

                            // If fullName is empty, use "Administrator" as fallback
                            if (string.IsNullOrEmpty(fullName))
                            {
                                fullName = "Administrator";
                            }

                            txtFullName.Text = fullName;
                            txtEmail.Text = reader["email"]?.ToString() ?? "";
                            txtPhone.Text = reader["cellNumber"]?.ToString() ?? "";

                            // Set profile image
                            string photoPath = reader["PhotoPath"]?.ToString();
                            if (!string.IsNullOrEmpty(photoPath))
                            {
                                imgProfile.ImageUrl = photoPath;
                            }
                            else
                            {
                                string imagePath = $"~/Images/Profile_{CurrentUserId}.jpg";
                                string physicalPath = Server.MapPath(imagePath);
                                if (System.IO.File.Exists(physicalPath))
                                {
                                    imgProfile.ImageUrl = imagePath;
                                }
                                else
                                {
                                    imagePath = $"~/Images/Profile_{CurrentUserId}.png";
                                    physicalPath = Server.MapPath(imagePath);
                                    if (System.IO.File.Exists(physicalPath))
                                    {
                                        imgProfile.ImageUrl = imagePath;
                                    }
                                    else
                                    {
                                        imgProfile.ImageUrl = "~/Images/default-avatar.png";
                                    }
                                }
                            }

                            // Set admin initials - FIXED: handle null/empty safely
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

                            lblAdminName.Text = fullName;
                        }
                        else
                        {
                            ShowError("User profile not found.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Error loading profile: " + ex.Message);
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

                string[] nameParts = fullName.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                string firstName = nameParts.Length > 0 ? nameParts[0] : "";
                string lastName = nameParts.Length > 1 ? string.Join(" ", nameParts.Skip(1)) : "";

                string query = @"
                    UPDATE Personal 
                    SET fname = @FirstName, 
                        lname = @LastName, 
                        cellNumber = @Phone
                    WHERE userId = @UserId";

                using (SqlConnection con = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                    con.Open();
                    cmd.ExecuteNonQuery();
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
                }

                ShowMessage("Profile updated successfully!");
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
                if (fuProfileImage.HasFile)
                {
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

                    string fileName = $"Profile_{CurrentUserId}{extension}";
                    string savePath = Path.Combine(folderPath, fileName);
                    fuProfileImage.SaveAs(savePath);

                    string photoPath = $"~/Images/{fileName}";
                    string query = @"
                        UPDATE Personal 
                        SET PhotoPath = @PhotoPath
                        WHERE userId = @UserId";

                    using (SqlConnection con = new SqlConnection(cs))
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                        cmd.Parameters.AddWithValue("@UserId", CurrentUserId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                    imgProfile.ImageUrl = photoPath + "?t=" + DateTime.Now.Ticks;
                    ShowMessage("Profile picture updated successfully!");
                }
                else
                {
                    ShowError("Please select an image file to upload.");
                }
            }
            catch (Exception ex)
            {
                ShowError("Error uploading image: " + ex.Message);
            }
        }
    }
}