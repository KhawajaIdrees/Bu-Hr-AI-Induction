using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using static System.Net.Mime.MediaTypeNames;


namespace WebApplication4
{
    public partial class candApply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    
        
            
        
       
        protected void RblApplyFor_SelectedIndexChanged(object sender, EventArgs e)
        {
            /* pnlFaculty.Visible = (rblApplyFor.SelectedValue == "Faculty");

            if (rblApplyFor.SelectedValue == "Faculty")
            {
                //cblPositions.Items.Clear();
                Session["ApplyFor"] = "Faculty";
                //rblPhD.ClearSelection();
            } */
        }
        private string UploadCV()
        {
            if (!fuCV.HasFile)
                return null;


            string extension =
                System.IO.Path.GetExtension(fuCV.FileName).ToLower();


            if (extension != ".pdf")
            {
                lblMessage.Text = "Only PDF files are allowed.";
                return null;
            }


            if (fuCV.PostedFile.ContentLength > 5242880)
            {
                lblMessage.Text = "CV size cannot exceed 5 MB.";
                return null;
            }


            string fileName =
                Guid.NewGuid().ToString() + extension;


            string folder =
                Server.MapPath("~/Uploads/CV/");


            if (!System.IO.Directory.Exists(folder))
                System.IO.Directory.CreateDirectory(folder);


            string fullPath =
                System.IO.Path.Combine(folder, fileName);


            fuCV.SaveAs(fullPath);


            return "~/Uploads/CV/" + fileName;
        }
        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           /* if (Session["UserID"] == null)
            {
                lblMessage.Text = "User session expired.";
                return;
            }


            // Teaching validation
            if (ddlJobApplied.SelectedValue == "Faculty")
            {
                if (string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                    string.IsNullOrWhiteSpace(txtSpecialization.Text))
                {
                    lblMessage.Text =
                        "Department and Specialization are required for Teaching.";

                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }


            string cvPath = UploadCV();


            SaveApplication(cvPath);


            lblMessage.Text = "Application saved successfully.";
            lblMessage.CssClass = "text-success";  */
        }


        protected void SaveApplication(int @uid, string @station, string @department, string @specialization, string path)
        {
            // Connection String
            string cs = "Data Source=(localdb)\\mssqllocaldb;Initial Catalog=HR;Integrated Security=True";
            string query = @"INSERT INTO Application VALUES (@uid, @station, @department, @specialization,@CVFileName)";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@uid", @uid);
                cmd.Parameters.AddWithValue("@station", @station);
                cmd.Parameters.AddWithValue("@department", @department);
                cmd.Parameters.AddWithValue("@specialization", @specialization);
                cmd.Parameters.AddWithValue("@CVFileName", @path);
                con.Open();
                cmd.ExecuteScalar();
                con.Close();
            }
            //lblMessage.Text = "Apply for info saved";
        }

        
    }

}
