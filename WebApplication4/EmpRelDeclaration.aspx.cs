using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class WebForm1 : System.Web.UI.Page
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

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT hasrelative,
                                name,
                                relationship,
                                dept,
                                designation
                         FROM EmpRelDeclaration
                         WHERE userId=@userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool hasRelative = Convert.ToBoolean(dr["hasrelative"]);

                            rblHasRelative.SelectedValue = hasRelative ? "Yes" : "No";

                            if (hasRelative)
                            {
                                txtName.Text = dr["name"].ToString();

                                string relationship = dr["relationship"] == DBNull.Value
                                    ? ""
                                    : dr["relationship"].ToString();

                                if (ddlRelationship.Items.FindByValue(relationship) != null)
                                    ddlRelationship.SelectedValue = relationship;
                                else
                                    ddlRelationship.SelectedIndex = 0;

                                txtDepartment.Text = dr["dept"].ToString();
                                txtDesignation.Text = dr["designation"].ToString();
                            }
                            else
                            {
                                ClearFields();
                            }
                        }
                        else
                        {
                            rblHasRelative.SelectedValue = "No";
                            ClearFields();
                        }
                    }
                }
            }
        }

        private void SaveEmpRelDeclaration(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
IF EXISTS(SELECT 1 FROM EmpRelDeclaration WHERE userId=@userId)
BEGIN
    UPDATE EmpRelDeclaration
    SET hasrelative=@hasrelative,
        name=@name,
        relationship=@relationship,
        dept=@dept,
        designation=@designation
    WHERE userId=@userId
END
ELSE
BEGIN
    INSERT INTO EmpRelDeclaration
    (userId,hasrelative,name,relationship,dept,designation)
    VALUES
    (@userId,@hasrelative,@name,@relationship,@dept,@designation)
END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    bool hasRelative = (rblHasRelative.SelectedValue == "Yes");
                    cmd.Parameters.Add("@hasrelative", SqlDbType.Bit).Value = hasRelative;
                    cmd.Parameters.Add("@name", SqlDbType.VarChar, 100).Value = txtName.Text.Trim();

                    if (string.IsNullOrEmpty(ddlRelationship.SelectedValue))
                        cmd.Parameters.Add("@relationship", SqlDbType.VarChar, 100).Value = DBNull.Value;
                    else
                        cmd.Parameters.Add("@relationship", SqlDbType.VarChar, 100).Value = ddlRelationship.SelectedValue;

                    cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value = txtDepartment.Text.Trim();
                    cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value = txtDesignation.Text.Trim();

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteEmpRelDeclaration(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM EmpRelDeclaration WHERE userId=@userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ClearFields()
        {
            txtName.Text = "";
            ddlRelationship.SelectedIndex = 0;
            txtDepartment.Text = "";
            txtDesignation.Text = "";
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                return;
            if (rblHasRelative.SelectedItem == null)
            {
                lblMessage.Text = "Please select Yes or No.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            // If user selected No, allow saving/continuing without filling details
            if (rblHasRelative.SelectedValue == "No")
            {
                try
                {
                    DeleteEmpRelDeclaration(userId);
                    ClearFields();

                    LoadCandidate();

                    lblMessage.Text = "Employment relationship declaration saved successfully.";
                    lblMessage.CssClass = "text-success";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                Response.Redirect("FriendDeclaration.aspx");
                return;
            }

            // From here on user selected Yes. Ensure validators passed
            if (!Page.IsValid)
                return;

            try
            {
                SaveEmpRelDeclaration(userId);

                LoadCandidate();

                lblMessage.Text = "Employment relationship declaration saved successfully.";
                lblMessage.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }

            Response.Redirect("FriendDeclaration.aspx");
        }
        
    }
}







