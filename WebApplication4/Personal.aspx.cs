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
                        // Profile Picture
                        if (reader["PhotoPath"] != DBNull.Value)
                        {
                            string photoPath = reader["PhotoPath"].ToString();

                            if (!string.IsNullOrEmpty(photoPath))
                            {
                                imgPicturePreview.Src = photoPath;
                                imgPicturePreview.Style["display"] = "inline-block";
                                picturePlaceholder.Style["display"] = "none";
                            }
                        }

                        // Identity Details
                        txtFirstName.Text = reader["fname"].ToString();
                        txtMiddleName.Text = reader["mname"] == DBNull.Value ? "" : reader["mname"].ToString();
                        txtLastName.Text = reader["lname"].ToString();
                        txtFatherName.Text = reader["fathername"].ToString();
                        txtCnic.Text = reader["cnic"].ToString();

                        if (ddlGender.Items.FindByValue(reader["gender"].ToString()) != null)
                            ddlGender.SelectedValue = reader["gender"].ToString();

                        txtCellNumber.Text = reader["cellNumber"].ToString();

                        if (reader["birthdate"] != DBNull.Value)
                        {
                            txtBirthDate.Text = Convert.ToDateTime(reader["birthdate"]).ToString("yyyy-MM-dd");
                        }

                        if (ddlMaritalStatus.Items.FindByValue(reader["marital"].ToString()) != null)
                            ddlMaritalStatus.SelectedValue = reader["marital"].ToString();

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
                    // User doesn't exist! Create one first.
                    lblMessage.Text = "Error: User ID " + userId + " does not exist in Users table. Please sign up first.";
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }

            // STEP 2: Upload picture with validation
            string photoPath = null;

            if (fuPicture.HasFile)
            {
                // VALIDATE: Check if file is an image
                string fileExtension = Path.GetExtension(fuPicture.FileName).ToLower();
                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp", ".tiff", ".ico" };

                if (!allowedExtensions.Contains(fileExtension))
                {
                    lblMessage.Text = "❌ Error: Please upload only image files (JPG, PNG, GIF, etc.)";
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                // Check file size (10MB max)
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

            // STEP 3: Update or Insert into Personal
            string query = @"
UPDATE Personal
SET
    PhotoPath = ISNULL(@PhotoPath, PhotoPath),
    fname = @fname,
    mname = @mname,
    lname = @lname,
    fathername = @fathername,
    cnic = @cnic,
    gender = @gender,
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
    prevdecl = @prevdecl
WHERE userId = @userId;

IF @@ROWCOUNT = 0
BEGIN
    INSERT INTO Personal
    (
        userId,
        PhotoPath,
        fname,
        mname,
        lname,
        fathername,
        cnic,
        gender,
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
        prevdecl
    )
    VALUES
    (
        @userId,
        @PhotoPath,
        @fname,
        @mname,
        @lname,
        @fathername,
        @cnic,
        @gender,
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
        @prevdecl
    )
END";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userId", userId);

                cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);

                cmd.Parameters.AddWithValue("@fname", txtFirstName.Text.Trim());

                cmd.Parameters.AddWithValue("@mname",
                    string.IsNullOrWhiteSpace(txtMiddleName.Text)
                    ? (object)DBNull.Value
                    : txtMiddleName.Text.Trim());

                cmd.Parameters.AddWithValue("@lname", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@fathername", txtFatherName.Text.Trim());
                cmd.Parameters.AddWithValue("@cnic", txtCnic.Text.Trim());
                cmd.Parameters.AddWithValue("@gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@cellNumber", txtCellNumber.Text.Trim());
                cmd.Parameters.AddWithValue("@birthdate", Convert.ToDateTime(txtBirthDate.Text));
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

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMessage.Text = "✅ Personal information saved successfully!";
            lblMessage.CssClass = "text-success";
        }

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            UpdatePersonal();

            // Only redirect if there's no error
            if (lblMessage.Text != "Error: User not logged in. Please sign up first." &&
                !lblMessage.Text.Contains("does not exist in Users table"))
            {
                Response.Redirect("PreviousEmployDeclaration.aspx");
            }
        }
    }
}