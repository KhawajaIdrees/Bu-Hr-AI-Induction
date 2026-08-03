using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class UserReference : Page
    {
        private int EditIndex
        {
            get
            {
                return ViewState["EditIndex"] == null
                    ? -1
                    : Convert.ToInt32(ViewState["EditIndex"]);
            }
            set
            {
                ViewState["EditIndex"] = value;
            }
        }

        private List<ReferenceModel> References
        {
            get
            {
                if (ViewState["References"] == null)
                    ViewState["References"] = new List<ReferenceModel>();

                return (List<ReferenceModel>)ViewState["References"];
            }
            set
            {
                ViewState["References"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadReferencesFromDatabase();
                BindReferences();
            }

            fuResume.Attributes["accept"] = ".pdf,.doc,.docx";
            txtPhone.Attributes["maxlength"] = "20";
            txtPhone.Attributes["oninput"] = "validatePhone(this)";

            txtYearsKnown.Attributes["min"] = "0";
            txtYearsKnown.Attributes["step"] = "1";
            txtYearsKnown.Attributes["oninput"] = "checkYear(this)";
            txtYearsKnown.Attributes["onchange"] = "checkYear(this)";
            txtYearsKnown.Attributes["onkeydown"] =
                "if(event.key=='-' || event.key=='e' || event.key=='+') event.preventDefault();";
        }

        private void LoadReferencesFromDatabase()
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"SELECT 
                                ReferenceID,
                                ReferenceName,
                                Relationship,
                                Organization,
                                JobTitle,
                                Email,
                                Phone,
                                Address,
                                YearsKnown
                            FROM UserReferences
                            WHERE UserID = @UserID
                            ORDER BY CreatedDate DESC";

            List<ReferenceModel> list = new List<ReferenceModel>();

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new ReferenceModel
                        {
                            ReferenceID = Convert.ToInt32(reader["ReferenceID"]),
                            ReferenceName = reader["ReferenceName"].ToString(),
                            Relationship = reader["Relationship"].ToString(),
                            Organization = reader["Organization"].ToString(),
                            JobTitle = reader["JobTitle"].ToString(),
                            Email = reader["Email"].ToString(),
                            Phone = reader["Phone"].ToString(),
                            Address = reader["Address"].ToString(),
                            YearsKnown = reader["YearsKnown"].ToString()
                        });
                    }
                }
            }

            References = list;
        }

        protected void btnAddReference_Click(object sender, EventArgs e)
        {
            if (!ValidateForm())
            {
                ShowMessage("Please fill all required fields.");
                return;
            }

            List<ReferenceModel> list = References;

            if (EditIndex >= 0)
            {
                list[EditIndex].ReferenceName = txtReferenceName.Text.Trim();
                list[EditIndex].Relationship = txtRelationship.Text.Trim();
                list[EditIndex].Organization = txtOrganization.Text.Trim();
                list[EditIndex].JobTitle = txtJobTitle.Text.Trim();
                list[EditIndex].Email = txtEmail.Text.Trim();
                list[EditIndex].Phone = txtPhone.Text.Trim();
                list[EditIndex].Address = txtAddress.Text.Trim();
                list[EditIndex].YearsKnown = txtYearsKnown.Text.Trim();

                References = list;
                EditIndex = -1;
                btnAddReference.Text = "+ Add";
                SaveReferencesToDatabase(list);
            }
            else
            {
                if (list.Count >= 2)
                {
                    ShowMessage("Maximum 2 references are allowed.");
                    return;
                }

                list.Add(new ReferenceModel
                {
                    ReferenceName = txtReferenceName.Text.Trim(),
                    Relationship = txtRelationship.Text.Trim(),
                    Organization = txtOrganization.Text.Trim(),
                    JobTitle = txtJobTitle.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Phone = txtPhone.Text.Trim(),
                    Address = txtAddress.Text.Trim(),
                    YearsKnown = txtYearsKnown.Text.Trim()
                });

                References = list;
                SaveReferencesToDatabase(list);
            }

            ClearForm();
            BindReferences();
            ShowMessage("Reference saved successfully!", true);
        }

        private void SaveReferencesToDatabase(List<ReferenceModel> references)
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string deleteQuery = "DELETE FROM UserReferences WHERE UserID = @UserID";
                using (SqlCommand deleteCmd = new SqlCommand(deleteQuery, con))
                {
                    deleteCmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                    deleteCmd.ExecuteNonQuery();
                }

                string insertQuery = @"
                    INSERT INTO UserReferences 
                    (UserID, ReferenceName, Relationship, Organization, JobTitle, Email, Phone, Address, YearsKnown)
                    VALUES 
                    (@UserID, @ReferenceName, @Relationship, @Organization, @JobTitle, @Email, @Phone, @Address, @YearsKnown)";

                foreach (var refModel in references)
                {
                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                    {
                        insertCmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                        insertCmd.Parameters.Add("@ReferenceName", SqlDbType.NVarChar).Value = refModel.ReferenceName;
                        insertCmd.Parameters.Add("@Relationship", SqlDbType.NVarChar).Value = refModel.Relationship;
                        insertCmd.Parameters.Add("@Organization", SqlDbType.NVarChar).Value = refModel.Organization;
                        insertCmd.Parameters.Add("@JobTitle", SqlDbType.NVarChar).Value = refModel.JobTitle;
                        insertCmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = refModel.Email;
                        insertCmd.Parameters.Add("@Phone", SqlDbType.NVarChar).Value = refModel.Phone;
                        insertCmd.Parameters.Add("@Address", SqlDbType.NVarChar).Value = refModel.Address;
                        insertCmd.Parameters.Add("@YearsKnown", SqlDbType.Int).Value = refModel.YearsKnown;

                        insertCmd.ExecuteNonQuery();
                    }
                }
            }
        }

        private void SaveCVToDatabase(string filePath)
        {
            int userID = Convert.ToInt32(Session["UserID"]);
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"UPDATE Personal 
                            SET CVPath = @CVPath, UpdatedAt = GETDATE() 
                            WHERE userId = @UserID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                cmd.Parameters.Add("@CVPath", SqlDbType.NVarChar).Value = filePath;
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void rptReferences_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            List<ReferenceModel> list = References;

            if (e.CommandName == "EditReference")
            {
                ReferenceModel item = list[index];
                txtReferenceName.Text = item.ReferenceName;
                txtRelationship.Text = item.Relationship;
                txtOrganization.Text = item.Organization;
                txtJobTitle.Text = item.JobTitle;
                txtEmail.Text = item.Email;
                txtPhone.Text = item.Phone;
                txtAddress.Text = item.Address;
                txtYearsKnown.Text = item.YearsKnown;

                EditIndex = index;
                btnAddReference.Text = "Update Reference";
                btnAddReference.Enabled = true;
                return;
            }

            if (e.CommandName == "DeleteReference")
            {
                list.RemoveAt(index);
                References = list;
                EditIndex = -1;
                btnAddReference.Text = "+ Add";
                btnAddReference.Enabled = true;
                ClearForm();
                SaveReferencesToDatabase(list);
                BindReferences();

                if (References.Count == 0)
                {
                    btnAddReference.Enabled = true;
                    btnAddReference.Text = "+ Add";
                }
            }
        }

        protected void btnSaveContinue_Click(object sender, EventArgs e)
        {
            if (References.Count == 0)
            {
                ShowMessage("Please add at least one reference.");
                return;
            }

            if (!fuResume.HasFile)
            {
                ShowMessage("Please upload your CV/Resume before continuing.");
                return;
            }

            string extension = System.IO.Path.GetExtension(fuResume.FileName).ToLower();
            string[] allowedExtensions = { ".pdf", ".doc", ".docx" };

            if (Array.IndexOf(allowedExtensions, extension) == -1)
            {
                ShowMessage("Only PDF, DOC and DOCX files are allowed.");
                return;
            }

            if (fuResume.PostedFile.ContentLength > (5 * 1024 * 1024))
            {
                ShowMessage("Maximum file size allowed is 5 MB.");
                return;
            }

            try
            {
                string uploadFolder = Server.MapPath("~/Uploads/Resumes/");
                if (!System.IO.Directory.Exists(uploadFolder))
                {
                    System.IO.Directory.CreateDirectory(uploadFolder);
                }

                string fileName = Guid.NewGuid().ToString() + extension;
                string filePath = System.IO.Path.Combine(uploadFolder, fileName);

                fuResume.SaveAs(filePath);
                SaveReferencesToDatabase(References);
                SaveCVToDatabase("~/Uploads/Resumes/" + fileName);

                Response.Redirect("ApplicationSummary.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message);
            }
        }

        private void BindReferences()
        {
            rptReferences.DataSource = References;
            rptReferences.DataBind();

            if (EditIndex >= 0)
            {
                btnAddReference.Enabled = true;
                return;
            }

            btnAddReference.Enabled = References.Count < 2;

            if (References.Count >= 2)
                ShowMessage("Maximum of 2 references are allowed.");
            else
                pnlMessage.Visible = false;
        }

        private bool ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtReferenceName.Text))
            {
                ShowMessage("Reference Name is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtRelationship.Text))
            {
                ShowMessage("Relationship is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtOrganization.Text))
            {
                ShowMessage("Organization is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtJobTitle.Text))
            {
                ShowMessage("Job Title is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Email Address is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                ShowMessage("Phone Number is required.");
                return false;
            }
            if (string.IsNullOrWhiteSpace(txtYearsKnown.Text))
            {
                ShowMessage("Years Known is required.");
                return false;
            }

            int years;
            if (!int.TryParse(txtYearsKnown.Text, out years))
            {
                ShowMessage("Years Known must be a valid number.");
                return false;
            }
            if (years < 0)
            {
                ShowMessage("Years Known cannot be negative.");
                return false;
            }

            return true;
        }

        private void ClearForm()
        {
            txtReferenceName.Text = "";
            txtRelationship.Text = "";
            txtOrganization.Text = "";
            txtJobTitle.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtAddress.Text = "";
            txtYearsKnown.Text = "";
        }

        private void ShowMessage(string message, bool isSuccess = false)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
            if (isSuccess)
            {
                pnlMessage.CssClass = "alert alert-success";
            }
            else
            {
                pnlMessage.CssClass = "alert alert-warning";
            }
        }
    }
}