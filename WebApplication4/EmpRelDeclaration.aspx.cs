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
                string query = @"
                SELECT name,
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
                            // Record exists
                            rblHasRelative.SelectedValue = "Yes";


                            txtName.Text =
                                dr["name"].ToString();


                            ddlRelationship.SelectedValue =
                                dr["relationship"].ToString();


                            txtDepartment.Text =
                                dr["dept"].ToString();


                            txtDesignation.Text =
                                dr["designation"].ToString();


                            pnlRelativeDetailsWrapper.Visible = true;
                        }
                        else
                        {
                            // No record
                            rblHasRelative.SelectedValue = "No";


                            txtName.Text = "";
                            ddlRelationship.SelectedIndex = 0;
                            txtDepartment.Text = "";
                            txtDesignation.Text = "";


                            pnlRelativeDetailsWrapper.Visible = false;
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

            IF EXISTS
            (
                SELECT 1 
                FROM EmpRelDeclaration
                WHERE userId=@userId
            )

            BEGIN

                UPDATE EmpRelDeclaration

                SET
                    name=@name,
                    relationship=@relationship,
                    dept=@dept,
                    designation=@designation

                WHERE userId=@userId

            END


            ELSE

            BEGIN

                INSERT INTO EmpRelDeclaration
                (
                    userId,
                    name,
                    relationship,
                    dept,
                    designation
                )

                VALUES
                (
                    @userId,
                    @name,
                    @relationship,
                    @dept,
                    @designation
                )

            END";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    cmd.Parameters.Add("@userId",
                        SqlDbType.Int).Value = userId;


                    cmd.Parameters.Add("@name",
                        SqlDbType.VarChar, 100)
                        .Value = txtName.Text.Trim();


                    cmd.Parameters.Add("@relationship",
                        SqlDbType.VarChar, 100)
                        .Value = ddlRelationship.SelectedValue;


                    cmd.Parameters.Add("@dept",
                        SqlDbType.VarChar, 100)
                        .Value = txtDepartment.Text.Trim();


                    cmd.Parameters.Add("@designation",
                        SqlDbType.VarChar, 100)
                        .Value = txtDesignation.Text.Trim();


                    con.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }



        private void DeleteEmpRelDeclaration(int userId)
        {

            using (SqlConnection con = new SqlConnection(cs))
            {

                string query = @"
                DELETE FROM EmpRelDeclaration
                WHERE userId=@userId";


                using (SqlCommand cmd = new SqlCommand(query, con))
                {

                    cmd.Parameters.Add("@userId",
                        SqlDbType.Int).Value = userId;


                    con.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }



        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            if (Session["UserId"] == null)
                return;


            int userId =
                Convert.ToInt32(Session["UserId"]);


            try
            {

                if (rblHasRelative.SelectedValue == "Yes")
                {
                    SaveEmpRelDeclaration(userId);
                }
                else
                {
                    DeleteEmpRelDeclaration(userId);
                }


                lblMessage.Text =
                    "Employment relationship declaration saved successfully.";

                lblMessage.CssClass =
                    "text-success";


            }
            catch (Exception ex)
            {

                lblMessage.Text =
                    ex.Message;

                lblMessage.CssClass =
                    "text-danger";

            }

        }

    }
}







