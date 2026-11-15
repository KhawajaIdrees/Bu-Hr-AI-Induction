using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;

namespace WebApplication4
{
    public partial class RegisterUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidate();
            }
        }

        protected void LoadCandidate()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT *
                     FROM Personal
                     WHERE userId = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;

                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Profile Picture — safe null checks
                        if (reader["PhotoPath"] != DBNull.Value)
                        {
                            string photoPath = reader["PhotoPath"].ToString();

                            if (!string.IsNullOrEmpty(photoPath))
                            {
                                if (imgPicturePreview != null)
                                {
                                    imgPicturePreview.Src = photoPath;
                                    imgPicturePreview.Style["display"] = "block";
                                }
                                if (picturePlaceholder != null)
                                {
                                    picturePlaceholder.Style["display"] = "none";
                                }
                            }
                        }

                        // Identity Details
                        txtFirstName.Text = reader["fname"].ToString();
                        txtMiddleName.Text = reader["mname"] == DBNull.Value ? "" : reader["mname"].ToString();
                        txtLastName.Text = reader["lname"].ToString();
                        txtFatherName.Text = reader["fathername"].ToString();
                        txtCnic.Text = reader["cnic"].ToString();

                        // null guard on ddlGender
                        if (ddlGender != null && reader["gender"] != DBNull.Value)
                        {
                            string gender = reader["gender"].ToString();
                            if (ddlGender.Items.FindByValue(gender) != null)
                                ddlGender.SelectedValue = gender;
                        }

                        // Passport No. — null guard
                        if (txtPassportNo != null && reader["PassportNo"] != DBNull.Value)
                        {
                            txtPassportNo.Text = reader["PassportNo"].ToString();
                        }

                        // NEW: Disability — null guard (column may not exist on very old DBs)
                        if (ddlDisability != null)
                        {
                            try
                            {
                                if (reader["Disability"] != DBNull.Value)
                                {
                                    string dis = reader["Disability"].ToString();
                                    if (ddlDisability.Items.FindByValue(dis) != null)
                                        ddlDisability.SelectedValue = dis;
                                }
                            }
                            catch (IndexOutOfRangeException)
                            {
                                // Column missing — ignore
                            }
                        }

                        txtCellNumber.Text = reader["cellNumber"].ToString();

                        if (reader["birthdate"] != DBNull.Value)
                        {
                            txtBirthDate.Text = Convert.ToDateTime(reader["birthdate"]).ToString("yyyy-MM-dd");
                        }

                        // null guard on ddlMaritalStatus
                        if (ddlMaritalStatus != null && reader["marital"] != DBNull.Value)
                        {
                            string marital = reader["marital"].ToString();
                            if (ddlMaritalStatus.Items.FindByValue(marital) != null)
                                ddlMaritalStatus.SelectedValue = marital;
                        }

                        // Background
                        txtNationality.Text = reader["nationality"].ToString();
                        txtReligion.Text = reader["religion"].ToString();
                        txtSect.Text = reader["sect"].ToString();

                        // Address
                        txtCountry.Text = reader["country"].ToString();
                        txtStateProvince.Text = reader["state"].ToString();
                        txtCity.Text = reader["city"].ToString();
                        txtCurrentAddress.Text = reader["curraddress"].ToString();
                        txtPermanentAddress.Text = reader["permaddress"].ToString();

                        // Declaration
                        bool prevApplied = Convert.ToBoolean(reader["prevdecl"]);
                        rblPreviouslyApplied.SelectedValue = prevApplied ? "Yes" : "No";

                        // Google Scholar Link
                        if (reader["GoogleScholarLink"] != DBNull.Value)
                        {
                            txtGoogleScholar.Text = reader["GoogleScholarLink"].ToString();
                        }

                        // LinkedIn Link
                        if (reader["LinkedInLink"] != DBNull.Value)
                        {
                            txtLinkedIn.Text = reader["LinkedInLink"].ToString();
                        }

                        // ORCID Link
                        if (reader["ORCIDLink"] != DBNull.Value)
                        {
                            txtORCID.Text = reader["ORCIDLink"].ToString();
                        }

                        // Existing CV indicator
                        if (reader["CVPath"] != DBNull.Value)
                        {
                            string cvPath = reader["CVPath"].ToString();

                            if (!string.IsNullOrEmpty(cvPath))
                            {
                                pnlCurrentCV.Visible = true;
                                lnkCurrentCV.NavigateUrl = ResolveUrl(cvPath);
                                lnkCurrentCV.Text = System.IO.Path.GetFileName(cvPath);
                            }
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Personal information does not exist.";
                    }
                }
            }
        }

        protected void UpdatePersonal()
        {
            // CHECK: Make sure UserID exists in Session
            if (Session["UserID"] == null)
            {
                lblMessage.Text = "Error: User not logged in. Please sign up first.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            // STEP 1: Check if the user exists in Users table
            string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE id = @userId";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand checkCmd = new SqlCommand(checkUserQuery, con);
                checkCmd.Parameters.AddWithValue("@userId", userId);

                int userExists = (int)checkCmd.ExecuteScalar();

                if (userExists == 0)
                {
                    lblMessage.Text = "Error: User ID " + userId + " does not exist in Users table. Please sign up first.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }

            // STEP 2: Upload picture + CV with validation
            string photoPath = null;
            string cvPath = null;

            // --- Profile picture ---
            if (fuPicture.HasFile)
            {
                string fileExtension = Path.GetExtension(fuPicture.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp", ".tiff", ".ico" };

                if (!allowedExtensions.Contains(fileExtension))
                {
                    lblMessage.Text = "❌ Error: Please upload only image files (JPG, PNG, GIF, etc.)";
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                if (fuPicture.PostedFile.ContentLength > 10 * 1024 * 1024)
                {
                    lblMessage.Text = "❌ Error: File size must be less than 10MB";
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                string extension = Path.GetExtension(fuPicture.FileName).ToLower();
                string fileName = Guid.NewGuid().ToString() + extension;

                string folder = Server.MapPath("~/Uploads/ProfilePictures/");

                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fullPath = Path.Combine(folder, fileName);
                fuPicture.SaveAs(fullPath);
                photoPath = "~/Uploads/ProfilePictures/" + fileName;
            }

            // --- CV / Resume (MANDATORY if not already saved) ---

            // Check if the user already has a CV saved in the database
            bool hasExistingCV = false;
            using (SqlConnection conCheck = new SqlConnection(cs))
            {
                conCheck.Open();
                using (SqlCommand cmdCheck = new SqlCommand("SELECT CVPath FROM Personal WHERE userId = @userId", conCheck))
                {
                    cmdCheck.Parameters.AddWithValue("@userId", userId);
                    object result = cmdCheck.ExecuteScalar();

                    if (result != null && result != DBNull.Value && !string.IsNullOrWhiteSpace(result.ToString()))
                    {
                        hasExistingCV = true;
                    }
                }
            }

            // If no CV is uploaded AND user doesn't have one saved yet → error
            if (!fuResume.HasFile && !hasExistingCV)
            {
                lblMessage.Text = "❌ Error: Please upload your CV before continuing.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            // If a CV file is uploaded, validate and save it
            if (fuResume.HasFile)
            {
                string cvExt = Path.GetExtension(fuResume.FileName).ToLower();
                string[] allowedCvExt = { ".pdf", ".doc", ".docx" };

                if (!allowedCvExt.Contains(cvExt))
                {
                    lblMessage.Text = "❌ Error: CV must be PDF, DOC or DOCX.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                if (fuResume.PostedFile.ContentLength > (15 * 1024 * 1024))
                {
                    lblMessage.Text = "❌ Error: CV file size must be less than 15MB.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                string cvFileName = Guid.NewGuid().ToString() + cvExt;
                string cvFolder = Server.MapPath("~/Uploads/Resumes/");

                if (!Directory.Exists(cvFolder))
                    Directory.CreateDirectory(cvFolder);

                string cvFullPath = Path.Combine(cvFolder, cvFileName);
                fuResume.SaveAs(cvFullPath);
                cvPath = "~/Uploads/Resumes/" + cvFileName;
            }

            // STEP 3: Update or Insert into Personal (Disability added)
            string query = @"
UPDATE Personal
SET
    PhotoPath = ISNULL(@PhotoPath, PhotoPath),
    CVPath = ISNULL(@CVPath, CVPath),
    fname = @fname,
    mname = @mname,
    lname = @lname,
    fathername = @fathername,
    cnic = @cnic,
    gender = @gender,
    PassportNo = @PassportNo,
    Disability = @Disability,
    cellNumber = @cellNumber,
    birthdate = @birthdate,
    marital = @marital,
    nationality = @nationality,
    religion = @religion,
    sect = @sect,
    country = @country,
    state = @state,
    city = @city,
    curraddress = @curraddress,
    permaddress = @permaddress,
    prevdecl = @prevdecl,
    GoogleScholarLink = @GoogleScholarLink,
    LinkedInLink = @LinkedInLink,
    ORCIDLink = @ORCIDLink,
    UpdatedAt = GETDATE()
WHERE userId = @userId;

IF @@ROWCOUNT = 0
BEGIN
    INSERT INTO Personal
    (
        userId,
        PhotoPath,
        CVPath,
        fname,
        mname,
        lname,
        fathername,
        cnic,
        gender,
        PassportNo,
        Disability,
        cellNumber,
        birthdate,
        marital,
        nationality,
        religion,
        sect,
        country,
        state,
        city,
        curraddress,
        permaddress,
        prevdecl,
        GoogleScholarLink,
        LinkedInLink,
        ORCIDLink
    )
    VALUES
    (
        @userId,
        @PhotoPath,
        @CVPath,
        @fname,
        @mname,
        @lname,
        @fathername,
        @cnic,
        @gender,
        @PassportNo,
        @Disability,
        @cellNumber,
        @birthdate,
        @marital,
        @nationality,
        @religion,
        @sect,
        @country,
        @state,
        @city,
        @curraddress,
        @permaddress,
        @prevdecl,
        @GoogleScholarLink,
        @LinkedInLink,
        @ORCIDLink
    )
END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userId", userId);

                cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@CVPath", (object)cvPath ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@fname", txtFirstName.Text.Trim());

                cmd.Parameters.AddWithValue("@mname",
                    string.IsNullOrWhiteSpace(txtMiddleName.Text)
                    ? (object)DBNull.Value
                    : txtMiddleName.Text.Trim());

                cmd.Parameters.AddWithValue("@lname", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@fathername", txtFatherName.Text.Trim());
                cmd.Parameters.AddWithValue("@cnic", txtCnic.Text.Trim());
                cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);

                // Passport No. (optional) — null guard for safety
                cmd.Parameters.AddWithValue("@PassportNo",
                    txtPassportNo == null || string.IsNullOrWhiteSpace(txtPassportNo.Text)
                    ? (object)DBNull.Value
                    : txtPassportNo.Text.Trim());

                // NEW: Disability (optional) — null guard
                cmd.Parameters.AddWithValue("@Disability",
                    ddlDisability == null || string.IsNullOrWhiteSpace(ddlDisability.SelectedValue)
                    ? (object)DBNull.Value
                    : ddlDisability.SelectedValue.Trim());

                cmd.Parameters.AddWithValue("@cellNumber", txtCellNumber.Text.Trim());

                // safer birthdate parsing
                DateTime parsedBirthDate;
                if (!DateTime.TryParse(txtBirthDate.Text, out parsedBirthDate))
                {
                    lblMessage.Text = "❌ Error: Please enter a valid Birth Date.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
                cmd.Parameters.AddWithValue("@birthdate", parsedBirthDate);

                cmd.Parameters.AddWithValue("@marital", ddlMaritalStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@nationality", txtNationality.Text.Trim());
                cmd.Parameters.AddWithValue("@religion", txtReligion.Text.Trim());
                cmd.Parameters.AddWithValue("@sect", txtSect.Text.Trim());
                cmd.Parameters.AddWithValue("@country", txtCountry.Text.Trim());
                cmd.Parameters.AddWithValue("@state", txtStateProvince.Text.Trim());
                cmd.Parameters.AddWithValue("@city", txtCity.Text.Trim());
                cmd.Parameters.AddWithValue("@curraddress", txtCurrentAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@permaddress", txtPermanentAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@prevdecl", rblPreviouslyApplied.SelectedValue == "Yes");

                cmd.Parameters.AddWithValue("@GoogleScholarLink",
                    string.IsNullOrWhiteSpace(txtGoogleScholar.Text)
                    ? (object)DBNull.Value
                    : txtGoogleScholar.Text.Trim());

                cmd.Parameters.AddWithValue("@LinkedInLink",
                    string.IsNullOrWhiteSpace(txtLinkedIn.Text)
                    ? (object)DBNull.Value
                    : txtLinkedIn.Text.Trim());

                cmd.Parameters.AddWithValue("@ORCIDLink",
                    string.IsNullOrWhiteSpace(txtORCID.Text)
                    ? (object)DBNull.Value
                    : txtORCID.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "✅ Personal information saved successfully!";
            lblMessage.CssClass = "text-success";
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            // Honor validators — don't save when required fields are missing
            if (!Page.IsValid)
                return;

            try
            {
                UpdatePersonal();

                // Only redirect if save was successful
                if (lblMessage.Text.StartsWith("✅"))
                {
                    Response.Redirect("PreviousEmployDeclaration.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "❌ Error: " + ex.Message;
                lblMessage.CssClass = "text-danger";
            }
        }
    }
}