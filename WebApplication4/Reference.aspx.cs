using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class Reference : Page
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
            if (!IsPostBack)
            {
                BindReferences();
            }

            // Restrict Resume Upload
            fuResume.Attributes["accept"] = ".pdf,.doc,.docx";

            // Phone Number
            txtPhone.Attributes["maxlength"] = "20";
            txtPhone.Attributes["oninput"] = "validatePhone(this)";

            // Years Known
            txtYearsKnown.Attributes["min"] = "0";
            txtYearsKnown.Attributes["step"] = "1";
            txtYearsKnown.Attributes["oninput"] = "checkYear(this)";
            txtYearsKnown.Attributes["onchange"] = "checkYear(this)";
            txtYearsKnown.Attributes["onkeydown"] =
                "if(event.key=='-' || event.key=='e' || event.key=='+') event.preventDefault();";
        }

        protected void btnAddReference_Click(object sender, EventArgs e)
        {
            if (!ValidateForm())
            {
                ShowMessage("Please fill all required fields.");
                return;
            }

            List<ReferenceModel> list = References;

            // UPDATE
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
            }
            // ADD
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
            }

            ClearForm();
            BindReferences();
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

                BindReferences();
            }
        }

        protected void btnSaveContinue_Click(object sender, EventArgs e)
        {
            // Check at least one reference
            if (References.Count == 0)
            {
                ShowMessage("Please add at least one reference.");
                return;
            }

            // CV/Resume is mandatory
            if (!fuResume.HasFile)
            {
                ShowMessage("Please upload your CV/Resume before continuing.");
                return;
            }

            // Allowed file extensions
            string extension = System.IO.Path.GetExtension(fuResume.FileName).ToLower();

            string[] allowedExtensions =
{
    ".pdf",
    ".doc",
    ".docx"
};

            if (Array.IndexOf(allowedExtensions, extension) == -1)
            {
                ShowMessage("Only PDF, DOC and DOCX files are allowed.");
                return;
            }

            // Maximum file size = 5 MB
            if (fuResume.PostedFile.ContentLength > (5 * 1024 * 1024))
            {
                ShowMessage("Maximum file size allowed is 5 MB.");
                return;
            }

            try
            {
                // Uploads folder
                string uploadFolder = Server.MapPath("~/Uploads/");

                if (!System.IO.Directory.Exists(uploadFolder))
                {
                    System.IO.Directory.CreateDirectory(uploadFolder);
                }

                // Unique filename
                string fileName =
                    Guid.NewGuid().ToString() +
                    System.IO.Path.GetExtension(fuResume.FileName);

                string filePath =
                    System.IO.Path.Combine(uploadFolder, fileName);

                // Save file
                fuResume.SaveAs(filePath);

                // TODO:
                // Save references and fileName into database here

                Response.Redirect("NextPage.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Error uploading file: " + ex.Message);
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

        private void ShowMessage(string message)
        {
            pnlMessage.Visible = true;
            lblMessage.Text = message;
        }
    }
}