using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class PreviousEmployment : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCandidate();
            }

            try
            {
                if (rblSuspensionTermination != null && pnlSuspensionDetailsWrapper != null)
                {
                    pnlSuspensionDetailsWrapper.Style["display"] =
                        (rblSuspensionTermination.SelectedValue == "Yes") ? "block" : "none";
                }
            }
            catch { }
        }

        private void LoadCandidate()
        {
            if (Session["UserId"] == null)
                return;

            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT hasworked, campus, dept, designation, duration, ReasonForLeaving
                FROM PrevEmpl
                WHERE userId = @userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool hasWorked = dr["hasworked"] != DBNull.Value && Convert.ToBoolean(dr["hasworked"]);

                            if (hasWorked)
                            {
                                rblPreviouslyWorked.SelectedValue = "Yes";

                                string campus = dr["campus"].ToString();
                                if (ddlCampus.Items.FindByValue(campus) != null)
                                    ddlCampus.SelectedValue = campus;
                                else
                                    ddlCampus.SelectedIndex = 0;

                                txtDepartment.Text = dr["dept"].ToString();
                                txtDesignation.Text = dr["designation"].ToString();
                                txtDuration.Text = dr["duration"].ToString();

                                if (dr["ReasonForLeaving"] != DBNull.Value)
                                {
                                    string reason = dr["ReasonForLeaving"].ToString();
                                    if (ddlReasonForLeaving.Items.FindByValue(reason) != null)
                                        ddlReasonForLeaving.SelectedValue = reason;
                                }
                            }
                            else
                            {
                                rblPreviouslyWorked.SelectedValue = "No";
                                ClearFields();
                            }
                        }
                        else
                        {
                            rblPreviouslyWorked.SelectedValue = "No";
                            ClearFields();
                        }
                    }
                }
            }

            LoadSuspensionTerminationData(userId);
        }

        private void LoadSuspensionTerminationData(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                        SELECT HasSuspensionOrTermination, OrganizationName, Designation, Details
                        FROM SuspensionTerminationDeclaration
                        WHERE UserId = @userId";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                        con.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                bool hasSuspension = dr["HasSuspensionOrTermination"] != DBNull.Value && Convert.ToBoolean(dr["HasSuspensionOrTermination"]);
                                rblSuspensionTermination.SelectedValue = hasSuspension ? "Yes" : "No";

                                if (hasSuspension)
                                {
                                    if (dr["OrganizationName"] != DBNull.Value)
                                        txtSuspensionOrg.Text = dr["OrganizationName"].ToString();

                                    if (dr["Designation"] != DBNull.Value)
                                        txtSuspensionDesignation.Text = dr["Designation"].ToString();

                                    if (dr["Details"] != DBNull.Value)
                                        txtSuspensionDetails.Text = dr["Details"].ToString();
                                }
                            }
                            else
                            {
                                rblSuspensionTermination.SelectedValue = "No";
                            }
                        }
                    }
                }
            }
            catch { }
        }

        private void SavePrevEmpl(int userId)
        {
            bool hasWorked = rblPreviouslyWorked.SelectedValue == "Yes";

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                IF EXISTS (SELECT 1 FROM PrevEmpl WHERE userId = @userId)
                BEGIN
                    UPDATE PrevEmpl
                    SET hasworked = @hasworked, campus = @campus, dept = @dept,
                        designation = @designation, duration = @duration,
                        ReasonForLeaving = @ReasonForLeaving, updatedDate = GETDATE()
                    WHERE userId = @userId
                END
                ELSE
                BEGIN
                    INSERT INTO PrevEmpl
                        (userId, hasworked, campus, dept, designation, duration, ReasonForLeaving)
                    VALUES
                        (@userId, @hasworked, @campus, @dept, @designation, @duration, @ReasonForLeaving)
                END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    cmd.Parameters.Add("@hasworked", SqlDbType.Bit).Value = hasWorked;

                    if (hasWorked)
                    {
                        cmd.Parameters.Add("@campus", SqlDbType.VarChar, 100).Value = ddlCampus.SelectedValue;
                        cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value = txtDepartment.Text.Trim();
                        cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value = txtDesignation.Text.Trim();
                        cmd.Parameters.Add("@duration", SqlDbType.VarChar, 100).Value = txtDuration.Text.Trim();
                        cmd.Parameters.Add("@ReasonForLeaving", SqlDbType.NVarChar, 500).Value =
                            string.IsNullOrEmpty(ddlReasonForLeaving.SelectedValue) ? DBNull.Value : (object)ddlReasonForLeaving.SelectedValue;
                    }
                    else
                    {
                        cmd.Parameters.Add("@campus", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@duration", SqlDbType.VarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@ReasonForLeaving", SqlDbType.NVarChar, 500).Value = DBNull.Value;
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void SaveSuspensionTermination(int userId)
        {
            bool hasSuspension = rblSuspensionTermination.SelectedValue == "Yes";

            EnsureSuspensionTableExists();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                IF EXISTS (SELECT 1 FROM SuspensionTerminationDeclaration WHERE UserId = @userId)
                BEGIN
                    UPDATE SuspensionTerminationDeclaration
                    SET HasSuspensionOrTermination = @HasSuspension,
                        OrganizationName = @OrganizationName,
                        Designation = @Designation,
                        Details = @Details,
                        UpdatedDate = GETDATE()
                    WHERE UserId = @userId
                END
                ELSE
                BEGIN
                    INSERT INTO SuspensionTerminationDeclaration
                        (UserId, HasSuspensionOrTermination, OrganizationName, Designation, Details)
                    VALUES
                        (@userId, @HasSuspension, @OrganizationName, @Designation, @Details)
                END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    cmd.Parameters.Add("@HasSuspension", SqlDbType.Bit).Value = hasSuspension;

                    if (hasSuspension)
                    {
                        cmd.Parameters.Add("@OrganizationName", SqlDbType.NVarChar, 200).Value = txtSuspensionOrg.Text.Trim();
                        cmd.Parameters.Add("@Designation", SqlDbType.NVarChar, 100).Value = txtSuspensionDesignation.Text.Trim();
                        cmd.Parameters.Add("@Details", SqlDbType.NVarChar).Value = txtSuspensionDetails.Text.Trim();
                    }
                    else
                    {
                        cmd.Parameters.Add("@OrganizationName", SqlDbType.NVarChar, 200).Value = DBNull.Value;
                        cmd.Parameters.Add("@Designation", SqlDbType.NVarChar, 100).Value = DBNull.Value;
                        cmd.Parameters.Add("@Details", SqlDbType.NVarChar).Value = DBNull.Value;
                    }

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void EnsureSuspensionTableExists()
        {
            try
            {
                string createTableQuery = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='SuspensionTerminationDeclaration' AND xtype='U')
                    BEGIN
                        CREATE TABLE SuspensionTerminationDeclaration (
                            Id INT IDENTITY(1,1) PRIMARY KEY,
                            UserId INT NOT NULL,
                            HasSuspensionOrTermination BIT NOT NULL DEFAULT 0,
                            OrganizationName NVARCHAR(200) NULL,
                            Designation NVARCHAR(100) NULL,
                            Details NVARCHAR(MAX) NULL,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            UpdatedDate DATETIME NULL
                        )
                    END
                    ELSE
                    BEGIN
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('SuspensionTerminationDeclaration') AND name = 'Details')
                            ALTER TABLE SuspensionTerminationDeclaration ADD Details NVARCHAR(MAX) NULL

                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('SuspensionTerminationDeclaration') AND name = 'OrganizationName')
                            ALTER TABLE SuspensionTerminationDeclaration ADD OrganizationName NVARCHAR(200) NULL

                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('SuspensionTerminationDeclaration') AND name = 'Designation')
                            ALTER TABLE SuspensionTerminationDeclaration ADD Designation NVARCHAR(100) NULL
                    END";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(createTableQuery, con))
                        cmd.ExecuteNonQuery();
                }
            }
            catch { }
        }

        private void ClearFields()
        {
            try
            {
                if (ddlCampus != null && ddlCampus.Items.Count > 0) ddlCampus.SelectedIndex = 0;
                if (txtDepartment != null) txtDepartment.Text = "";
                if (txtDesignation != null) txtDesignation.Text = "";
                if (txtDuration != null) txtDuration.Text = "";
                if (ddlReasonForLeaving != null && ddlReasonForLeaving.Items.Count > 0) ddlReasonForLeaving.SelectedIndex = 0;
                if (txtSuspensionOrg != null) txtSuspensionOrg.Text = "";
                if (txtSuspensionDesignation != null) txtSuspensionDesignation.Text = "";
                if (txtSuspensionDetails != null) txtSuspensionDetails.Text = "";
            }
            catch { }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            lblMessage.Text = "";
            lblSuspensionError.Visible = false;

            if (rblPreviouslyWorked.SelectedItem == null)
            {
                ShowBottomError("Please select Yes or No for previous employment.");
                return;
            }

            if (string.IsNullOrEmpty(rblSuspensionTermination.SelectedValue))
            {
                lblSuspensionError.Visible = true;
                ShowBottomError("Please select Yes or No for suspension/termination.");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            // Suspension validation (server-side backup)
            if (rblSuspensionTermination.SelectedValue == "Yes")
            {
                if (string.IsNullOrWhiteSpace(txtSuspensionOrg.Text))
                {
                    ShowBottomError("Please enter organization name.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtSuspensionDesignation.Text))
                {
                    ShowBottomError("Please enter designation.");
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtSuspensionDetails.Text))
                {
                    ShowBottomError("Please provide details and reasons.");
                    return;
                }
            }

            // Previous employment validation
            if (rblPreviouslyWorked.SelectedValue == "Yes")
            {
                if (string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                    string.IsNullOrWhiteSpace(txtDesignation.Text) ||
                    string.IsNullOrWhiteSpace(txtDuration.Text) ||
                    string.IsNullOrWhiteSpace(ddlCampus.SelectedValue) ||
                    string.IsNullOrWhiteSpace(ddlReasonForLeaving.SelectedValue))
                {
                    ShowBottomError("Please complete all required fields for previous employment.");
                    return;
                }
            }

            try
            {
                SavePrevEmpl(userId);
                SaveSuspensionTermination(userId);

                lblMessage.Text = "Declaration saved successfully.";
                lblMessage.CssClass = "text-success d-block mt-3";
                lblMessage.ForeColor = System.Drawing.Color.Green;

                Response.Redirect("EmpRelDeclaration.aspx");
            }
            catch (Exception ex)
            {
                ShowBottomError(ex.Message);
            }
        }

        private void ShowBottomError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "text-danger d-block mt-3";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}