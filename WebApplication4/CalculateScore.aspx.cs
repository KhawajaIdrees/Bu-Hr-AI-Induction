using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class CalculateScore : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

        }

        protected void Login_Click(object sender, EventArgs e)
        {
            
        }



        private void LoadEduGrid()
        {
           
            string query = @"
        SELECT *
        FROM Candidate
        INNER JOIN Degree
            ON Candidate.userId = Degree.userId";
            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    con.Open();
                    da.Fill(dt);

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
        private void DisplayEduScore()
        {
            string query = @"
    SELECT
    c.userId,
    c.name,
    STRING_AGG(d.type, ', ') AS Degrees,
    CASE
        WHEN MAX(CASE WHEN d.type = 'PhD' THEN 1 ELSE 0 END) = 1 THEN 40
        WHEN MAX(CASE WHEN d.type = 'MS' THEN 1 ELSE 0 END) = 1 THEN 25
        ELSE 15
    END AS Score
FROM Candidate c
LEFT JOIN Degree d
    ON c.userId = d.userId
GROUP BY
    c.userId,
    c.name";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();

                con.Open();
                da.Fill(dt);

                GridView2.DataSource = dt;
                GridView2.DataBind();
            }
        }


        private void UpdateEduScore()
        {
            string query = @"
USE HR;

MERGE INTO Score AS target
USING
(
    SELECT
        c.userId,
        CASE
            WHEN MAX(CASE WHEN d.type = 'PhD' THEN 1 ELSE 0 END) = 1 THEN 40
            WHEN MAX(CASE WHEN d.type = 'MS' THEN 1 ELSE 0 END) = 1 THEN 25
            ELSE 15
        END AS eduScore
    FROM Candidate c
    LEFT JOIN Degree d
        ON c.userId = d.userId
    GROUP BY c.userId
) AS source
ON target.userId = source.userId

WHEN MATCHED THEN
    UPDATE
    SET target.eduScore = source.eduScore

WHEN NOT MATCHED THEN
    INSERT (userId, eduScore)
    VALUES (source.userId, source.eduScore);";

            string cs = ConfigurationManager.ConnectionStrings["MyDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        protected void CalcEduScore_Click(object sender, EventArgs e)
        {
            LoadEduGrid();
            DisplayEduScore();
            UpdateEduScore();
        }

        protected void CalcJobScore_Click(object sender, EventArgs e)
        {
           // LoadJobGrid();
            //DisplayJobScore();
               
               
                

        }

        protected void CalcResearchScore_Click(object sender, EventArgs e)
        {

        }
    }
        
    
}
