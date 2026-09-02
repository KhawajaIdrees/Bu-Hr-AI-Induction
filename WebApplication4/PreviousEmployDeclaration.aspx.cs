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
        }

        private void LoadCandidate()
        {
            if (Session["UserId"] == null)
                return;

            int userId = Convert.ToInt32(Session["UserId"]);

            // Load Previous Employment Data
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                SELECT hasworked,
                       campus,
                       dept,
                       designation,
                       duration,
                       ReasonForLeaving
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
                                {
                                    ddlCampus.SelectedValue = campus;
                                }
                                else
                                {
                                    ddlCampus.SelectedIndex = 0;
                                }

                                txtDepartment.Text = dr["dept"].ToString();
                                txtDesignation.Text = dr["designation"].ToString();
                                txtDuration.Text = dr["duration"].ToString();

                                // Load Reason for Leaving - Dropdown
                                if (dr["ReasonForLeaving"] != DBNull.Value)
                                {
                                    string reason = dr["ReasonForLeaving"].ToString();
                                    if (ddlReasonForLeaving.Items.FindByValue(reason) != null)
                                    {
                                        ddlReasonForLeaving.SelectedValue = reason;
                                    }
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

            // Load Suspension/Termination Data
            LoadSuspensionTerminationData(userId);
        }

        private void LoadSuspensionTerminationData(int userId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"
                        SELECT HasSuspensionOrTermination, Details
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

                                if (hasSuspension && dr["Details"] != DBNull.Value)
                                {
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
            catch
            {
                // Table might not exist yet, silently continue
            }
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
                    SET hasworked   = @hasworked,
                        campus      = @campus,
                        dept        = @dept,
                        designation = @designation,
                        duration    = @duration,
                        ReasonForLeaving = @ReasonForLeaving,
                        updatedDate = GETDATE()
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

                        // Save Reason for Leaving from Dropdown
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
                        Details = @Details,
                        UpdatedDate = GETDATE()
                    WHERE UserId = @userId
                END
                ELSE
                BEGIN
                    INSERT INTO SuspensionTerminationDeclaration
                        (UserId, HasSuspensionOrTermination, Details)
                    VALUES
                        (@userId, @HasSuspension, @Details)
                END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    cmd.Parameters.Add("@HasSuspension", SqlDbType.Bit).Value = hasSuspension;

                    if (hasSuspension)
                    {
                        cmd.Parameters.Add("@Details", SqlDbType.NVarChar).Value = txtSuspensionDetails.Text.Trim();
                    }
                    else
                    {
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
                            Details NVARCHAR(MAX) NULL,
                            CreatedDate DATETIME DEFAULT GETDATE(),
                            UpdatedDate DATETIME NULL
                        )
                    END
                    ELSE
                    BEGIN
                        IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('SuspensionTerminationDeclaration') AND name = 'Details')
                        BEGIN
                            ALTER TABLE SuspensionTerminationDeclaration ADD Details NVARCHAR(MAX) NULL
                        END
                    END";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(createTableQuery, con))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch
            {
                // Silent fail
            }
        }

        private void ClearFields()
        {
            try
            {
                // Only reset controls if they exist (page is fully loaded)
                if (ddlCampus != null && ddlCampus.Items.Count > 0)
                    ddlCampus.SelectedIndex = 0;

                if (txtDepartment != null)
                    txtDepartment.Text = "";

                if (txtDesignation != null)
                    txtDesignation.Text = "";

                if (txtDuration != null)
                    txtDuration.Text = "";

                if (ddlReasonForLeaving != null && ddlReasonForLeaving.Items.Count > 0)
                    ddlReasonForLeaving.SelectedIndex = 0;

                if (txtSuspensionDetails != null)
                    txtSuspensionDetails.Text = "";
            }
            catch
            {
                // Silent fail - controls might not be fully initialized
            }
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Check if Previous Employment radio is selected
            if (rblPreviouslyWorked.SelectedItem == null)
            {
                lblMessage.Text = "Please select Yes or No for previous employment.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            // Check if Suspension/Termination radio is selected - SERVER SIDE CHECK
            if (string.IsNullOrEmpty(rblSuspensionTermination.SelectedValue))
            {
                lblSuspensionError.Visible = true;
                lblMessage.Text = "Please select Yes or No for suspension/termination.";
                lblMessage.CssClass = "text-danger";
                return;
            }
            else
            {
                lblSuspensionError.Visible = false;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            // *** FIX: Disable suspension details validator if "No" is selected ***
            if (rblSuspensionTermination.SelectedValue == "No")
            {
                rfvSuspensionDetails.Enabled = false;
                rfvSuspensionDetails.IsValid = true;
            }
            else
            {
                rfvSuspensionDetails.Enabled = true;
            }

            // If user selected No for previous employment
            if (rblPreviouslyWorked.SelectedValue == "No")
            {
                try
                {
                    SavePrevEmpl(userId);
                    SaveSuspensionTermination(userId);

                    lblMessage.Text = "Declaration saved successfully.";
                    lblMessage.CssClass = "text-success";

                    LoadCandidate();

                    Response.Redirect("EmpRelDeclaration.aspx");
                    return;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.CssClass = "text-danger";
                    return;
                }
            }

            // User selected Yes - validate all fields
            if (!Page.IsValid)
            {
                lblMessage.Text = "Please complete all required fields.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            // SAFETY CHECK: Additional validation for required fields
            if (string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                string.IsNullOrWhiteSpace(txtDesignation.Text) ||
                string.IsNullOrWhiteSpace(txtDuration.Text) ||
                string.IsNullOrWhiteSpace(ddlCampus.SelectedValue))
            {
                lblMessage.Text = "Please complete all required fields.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            // Validate suspension details ONLY if Yes is selected
            if (rblSuspensionTermination.SelectedValue == "Yes" &&
                string.IsNullOrWhiteSpace(txtSuspensionDetails.Text))
            {
                lblMessage.Text = "Please provide details for suspension/termination.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            try
            {
                SavePrevEmpl(userId);
                SaveSuspensionTermination(userId);

                lblMessage.Text = "Declaration saved successfully.";
                lblMessage.CssClass = "text-success";

                LoadCandidate();
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
                return;
            }

            Response.Redirect("EmpRelDeclaration.aspx");
        }
    }
}