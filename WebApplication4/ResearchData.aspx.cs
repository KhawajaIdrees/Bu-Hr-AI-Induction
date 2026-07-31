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
    public partial class ResearchData : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPublications();
            }
        }

        protected void LoadPublications()
        {
            if (Session["UserID"] == null)
                return;

            int userID = Convert.ToInt32(Session["UserID"]);

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            // Use SELECT * with proper WHERE clause
            string query = @"SELECT * FROM Publications WHERE user_id = @userID ORDER BY CreatedAt DESC";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userID;

                con.Open();

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No publications added yet.";
                        gvPublications.Visible = false;
                    }
                    else
                    {
                        gvPublications.Visible = true;
                        lblMessage.Text = "";
                    }

                    gvPublications.DataSource = dt;
                    gvPublications.DataBind();
                }
            }
        }


        protected void AddPublication()
        {
            int userID = Convert.ToInt32(Session["UserID"]);

            // FIXED: Use correct column names (2 P's)
            string query = @"
INSERT INTO Publications
(
    user_id,
    ImpactFactor,
    HECPublications,
    ConferencePaper,
    ImpactFactor2,
    ConferencePaper2,
    WCount,
    XCount,
    YCount,
    TotalFundedProjects,
    PIProjects,
    CoPIProjects,
    MSStudents,
    MPhilStudents,
    PhDStudents
)
VALUES
(
    @userId,
    @ImpactFactor,
    @HECPublications,
    @ConferencePaper,
    @ImpactFactor2,
    @ConferencePaper2,
    @WCount,
    @XCount,
    @YCount,
    @TotalFundedProjects,
    @PIProjects,
    @CoPIProjects,
    @MSStudents,
    @MPhilStudents,
    @PhDStudents
)";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userID;

                cmd.Parameters.Add("@ImpactFactor", SqlDbType.VarChar).Value =
                    ddlImpactFactor.SelectedValue;

                cmd.Parameters.Add("@HECPublications", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtHECPublications.Text)
                        ? 0
                        : Convert.ToInt32(txtHECPublications.Text.Trim());

                cmd.Parameters.Add("@ConferencePaper", SqlDbType.VarChar).Value =
                    ddlConferencePaper.SelectedValue;

                cmd.Parameters.Add("@ImpactFactor2", SqlDbType.VarChar).Value =
                    ddlImpactFactor2.SelectedValue;

                cmd.Parameters.Add("@ConferencePaper2", SqlDbType.VarChar).Value =
                    ddlConferencePaper2.SelectedValue;

                cmd.Parameters.Add("@WCount", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtWCount.Text)
                        ? 0
                        : Convert.ToInt32(txtWCount.Text.Trim());

                cmd.Parameters.Add("@XCount", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtXCount.Text)
                        ? 0
                        : Convert.ToInt32(txtXCount.Text.Trim());

                cmd.Parameters.Add("@YCount", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtYCount.Text)
                        ? 0
                        : Convert.ToInt32(txtYCount.Text.Trim());

                cmd.Parameters.Add("@TotalFundedProjects", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtTotalFundedProjects.Text)
                        ? 0
                        : Convert.ToInt32(txtTotalFundedProjects.Text.Trim());

                // FIXED: Use correct parameter names (2 P's)
                cmd.Parameters.Add("@PIProjects", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtPIProjects.Text)
                        ? 0
                        : Convert.ToInt32(txtPIProjects.Text.Trim());

                cmd.Parameters.Add("@CoPIProjects", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtCoPIProjects.Text)
                        ? 0
                        : Convert.ToInt32(txtCoPIProjects.Text.Trim());

                cmd.Parameters.Add("@MSStudents", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtMSStudents.Text)
                        ? 0
                        : Convert.ToInt32(txtMSStudents.Text.Trim());

                cmd.Parameters.Add("@MPhilStudents", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtMPhilStudents.Text)
                        ? 0
                        : Convert.ToInt32(txtMPhilStudents.Text.Trim());

                cmd.Parameters.Add("@PhDStudents", SqlDbType.Int).Value =
                    string.IsNullOrWhiteSpace(txtPhDStudents.Text)
                        ? 0
                        : Convert.ToInt32(txtPhDStudents.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }
        
        }


        protected void BtnAdd_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (string.IsNullOrEmpty(ddlImpactFactor.SelectedValue) ||
                string.IsNullOrEmpty(ddlImpactFactor2.SelectedValue))
            {
                lblMessage.Text = "Please select Impact Factor options before adding.";
                lblMessage.CssClass = "ms-3 text-danger";
                return;
            }

            try
            {
                AddPublication();
                lblMessage.Text = "Publication added successfully.";
                lblMessage.CssClass = "ms-3 text-success";
                ClearInputs();
                LoadPublications();
            }
            catch (SqlException ex)
            {
                lblMessage.Text = "Database error: " + ex.Message;
                lblMessage.CssClass = "ms-3 text-danger";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "ms-3 text-danger";
            }
        }


        protected void ClearInputs()
        {
            ddlImpactFactor.SelectedIndex = 0;
            txtHECPublications.Text = string.Empty;
            ddlConferencePaper.SelectedIndex = 0;
            ddlImpactFactor2.SelectedIndex = 0;
            ddlConferencePaper2.SelectedIndex = 0;
            txtWCount.Text = string.Empty;
            txtXCount.Text = string.Empty;
            txtYCount.Text = string.Empty;
            txtTotalFundedProjects.Text = string.Empty;
            txtPIProjects.Text = string.Empty;
            txtCoPIProjects.Text = string.Empty;
            txtMSStudents.Text = string.Empty;
            txtMPhilStudents.Text = string.Empty;
            txtPhDStudents.Text = string.Empty;
        }


        protected void gvPublications_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                return;

            if (gvPublications.SelectedRow == null)
                return;

            int publicationId = Convert.ToInt32(
                gvPublications.SelectedRow.Cells[0].Text);

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            string query = @"DELETE FROM Publications
                     WHERE id = @id AND user_id = @userID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = publicationId;
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value =
                    Convert.ToInt32(Session["UserID"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadPublications();
        }


        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Education.aspx");
        }
    }
}