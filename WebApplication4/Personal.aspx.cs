using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
                        //=========================
                        // Profile Picture
                        //=========================
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


                        //=========================
                        // Identity Details
                        //=========================
                        txtFirstName.Text = reader["fname"].ToString();

                        txtMiddleName.Text = reader["mname"] == DBNull.Value
                            ? ""
                            : reader["mname"].ToString();

                        txtLastName.Text = reader["lname"].ToString();

                        txtFatherName.Text = reader["fathername"].ToString();

                        txtCnic.Text = reader["cnic"].ToString();


                        if (ddlGender.Items.FindByValue(reader["gender"].ToString()) != null)
                            ddlGender.SelectedValue = reader["gender"].ToString();


                        txtCellNumber.Text = reader["cellNumber"].ToString();


                        if (reader["birthdate"] != DBNull.Value)
                        {
                            txtBirthDate.Text =
                                Convert.ToDateTime(reader["birthdate"])
                                .ToString("yyyy-MM-dd");
                        }


                        if (ddlMaritalStatus.Items.FindByValue(reader["marital"].ToString()) != null)
                            ddlMaritalStatus.SelectedValue = reader["marital"].ToString();



                        //=========================
                        // Background
                        //=========================
                        txtNationality.Text = reader["nationality"].ToString();
                        txtReligion.Text = reader["religion"].ToString();
                        txtSect.Text = reader["sect"].ToString();



                        //=========================
                        // Address
                        //=========================
                        txtCountry.Text = reader["country"].ToString();
                        txtStateProvince.Text = reader["state"].ToString();
                        txtCity.Text = reader["city"].ToString();

                        txtCurrentAddress.Text = reader["curraddress"].ToString();
                        txtPermanentAddress.Text = reader["permaddress"].ToString();



                        //=========================
                        // Declaration
                        //=========================
                        bool prevApplied = Convert.ToBoolean(reader["prevdecl"]);

                        rblPreviouslyApplied.SelectedValue =
                            prevApplied ? "Yes" : "No";
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
            string photoPath = null;

            // Upload picture only if user selec"ts a new one
            if (fuPicture.HasFile)
            {
                string extension = System.IO.Path.GetExtension(fuPicture.FileName).ToLower();
                string fileName = Guid.NewGuid().ToString() + extension;

                string folder = Server.MapPath("~/Uploads/ProfilePictures/");

                if (!System.IO.Directory.Exists(folder))
                    System.IO.Directory.CreateDirectory(folder);

                string fullPath = System.IO.Path.Combine(folder, fileName);

                fuPicture.SaveAs(fullPath);

                photoPath = "~/Uploads/ProfilePictures/" + fileName;
            }

            /*else
           /* {
                if (!fuPicture.HasFile)
                {
                    picMsg.Text = "Please upload a picture.";
                    picMsg.CssClass = "text-danger";
                    return;
                }
            }*/
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
           

           

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;


            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@userId",
                    Convert.ToInt32(Session["UserID"]));

                cmd.Parameters.AddWithValue("@PhotoPath",
                    (object)photoPath ?? DBNull.Value);


                cmd.Parameters.AddWithValue("@fname",
                    txtFirstName.Text.Trim());

                cmd.Parameters.AddWithValue("@mname",
                string.IsNullOrWhiteSpace(txtMiddleName.Text)
                ? (object)DBNull.Value
                : txtMiddleName.Text.Trim());

                cmd.Parameters.AddWithValue("@lname",
                    txtLastName.Text.Trim());

                cmd.Parameters.AddWithValue("@fathername",
                    txtFatherName.Text.Trim());

                cmd.Parameters.AddWithValue("@cnic",
                    txtCnic.Text.Trim());

                cmd.Parameters.AddWithValue("@gender",
                    ddlGender.SelectedValue);


                cmd.Parameters.AddWithValue("@cellNumber",
                    txtCellNumber.Text.Trim());


                cmd.Parameters.AddWithValue("@birthdate",
                    Convert.ToDateTime(txtBirthDate.Text));


                cmd.Parameters.AddWithValue("@marital",
                    ddlMaritalStatus.SelectedValue);


                cmd.Parameters.AddWithValue("@nationality",
                    txtNationality.Text.Trim());


                cmd.Parameters.AddWithValue("@religion",
                    txtReligion.Text.Trim());


                cmd.Parameters.AddWithValue("@sect",
                    txtSect.Text.Trim());


                cmd.Parameters.AddWithValue("@country",
                    txtCountry.Text.Trim());


                cmd.Parameters.AddWithValue("@state",
                    txtStateProvince.Text.Trim());


                cmd.Parameters.AddWithValue("@city",
                    txtCity.Text.Trim());


                cmd.Parameters.AddWithValue("@curraddress",
                    txtCurrentAddress.Text.Trim());


                cmd.Parameters.AddWithValue("@permaddress",
                    txtPermanentAddress.Text.Trim());


                cmd.Parameters.AddWithValue("@prevdecl",
                    rblPreviouslyApplied.SelectedValue == "Yes");


                con.Open();
                cmd.ExecuteNonQuery();
             
            }
        }
        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            {
                
                UpdatePersonal();
               // lblMessage.Text = "Personal details entered successfully.";
                Response.Redirect("PreviousEmployDeclaration.aspx");
            }

        }
    }
}






    




     