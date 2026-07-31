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
    public partial class FriendDeclaration : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

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
                string query = @"SELECT hasfriend,
                                name,
                                relationship,
                                dept,
                                designation
                         FROM FriendDeclaration
                         WHERE userId=@userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool hasFriend = Convert.ToBoolean(dr["hasfriend"]);

                            rblHasFriend.SelectedValue = hasFriend ? "Yes" : "No";

                            if (hasFriend)
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
                            rblHasFriend.SelectedValue = "No";
                            ClearFields();
                        }
                    }
                }
            }
        }

        private void SaveFriendDeclaration(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
IF EXISTS(SELECT 1 FROM FriendDeclaration WHERE userId=@userId)
BEGIN
    UPDATE FriendDeclaration
    SET hasfriend=@hasfriend,
        name=@name,
        relationship=@relationship,
        dept=@dept,
        designation=@designation
    WHERE userId=@userId
END
ELSE
BEGIN
    INSERT INTO FriendDeclaration
    (
        userId,
        hasfriend,
        name,
        relationship,
        dept,
        designation
    )
    VALUES
    (
        @userId,
        @hasfriend,
        @name,
        @relationship,
        @dept,
        @designation
    )
END";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    bool hasFriend = (rblHasFriend.SelectedValue == "Yes");
                    cmd.Parameters.Add("@hasfriend", SqlDbType.Bit).Value = hasFriend;

                    cmd.Parameters.Add("@name", SqlDbType.VarChar, 100).Value =
                        txtName.Text.Trim();

                    if (string.IsNullOrEmpty(ddlRelationship.SelectedValue))
                        cmd.Parameters.Add("@relationship", SqlDbType.VarChar, 100).Value = DBNull.Value;
                    else
                        cmd.Parameters.Add("@relationship", SqlDbType.VarChar, 100).Value =
                            ddlRelationship.SelectedValue;

                    cmd.Parameters.Add("@dept", SqlDbType.VarChar, 100).Value =
                        txtDepartment.Text.Trim();

                    cmd.Parameters.Add("@designation", SqlDbType.VarChar, 100).Value =
                        txtDesignation.Text.Trim();

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteFriendDeclaration(int userId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM FriendDeclaration WHERE userId=@userId";

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

            if (rblHasFriend.SelectedItem == null)
            {
                lblMessage.Text = "Please select Yes or No.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            // If user selected No, we should allow saving/continuing without filling details.
            if (rblHasFriend.SelectedValue == "No")
            {
                try
                {
                    // Remove any existing declaration for this user and clear fields
                    DeleteFriendDeclaration(userId);
                    ClearFields();

                    LoadCandidate();

                    lblMessage.Text = "Friend declaration saved successfully.";
                    lblMessage.CssClass = "text-success";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = ex.Message;
                    lblMessage.CssClass = "text-danger";
                    return;
                }

                Response.Redirect("Experience.aspx");
                return;
            }

            // From here on user selected Yes. Ensure validation succeeded.
            if (!Page.IsValid)
                return;

            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtDepartment.Text) ||
                string.IsNullOrWhiteSpace(txtDesignation.Text) ||
                string.IsNullOrWhiteSpace(ddlRelationship.SelectedValue))
            {
                lblMessage.Text = "Please complete all required fields.";
                lblMessage.CssClass = "text-danger";
                return;
            }


            try
            {
                if (rblHasFriend.SelectedValue == "Yes")
                {
                    SaveFriendDeclaration(userId);
                }
                else
                {
                    DeleteFriendDeclaration(userId);
                    ClearFields();
                }

                LoadCandidate();

                lblMessage.Text = "Friend declaration saved successfully.";
                lblMessage.CssClass = "text-success";
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.CssClass = "text-danger";
            }
            Response.Redirect("Experience.aspx");
        }
        
    }
}