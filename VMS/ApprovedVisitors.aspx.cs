using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class ApprovedVisitors : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadApprovedVisitors();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadApprovedVisitors(txtSearch.Text.Trim());
        }

        private void LoadApprovedVisitors(string keyword = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT DetailId, Name, Email, Mobile, Department, PersonToMeet, VisitingTime, createdAt
                                 FROM Details
                                 WHERE Status = 'Approved'";

                if (!string.IsNullOrEmpty(keyword))
                {
                    query += @" AND (
                        Name LIKE @keyword OR 
                        Mobile LIKE @keyword OR 
                        Department LIKE @keyword
                    )";
                }

                query += " ORDER BY createdAt DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(keyword))
                    cmd.Parameters.AddWithValue("@keyword", "%" + keyword + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvApprovedVisitors.DataKeyNames = new string[] { "DetailId" };
                gvApprovedVisitors.DataSource = dt;
                gvApprovedVisitors.DataBind();
            }
        }

        protected void gvApprovedVisitors_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvApprovedVisitors.EditIndex = e.NewEditIndex;
            LoadApprovedVisitors(txtSearch.Text.Trim());
        }

        protected void gvApprovedVisitors_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvApprovedVisitors.EditIndex = -1;
            LoadApprovedVisitors(txtSearch.Text.Trim());
        }

        protected void gvApprovedVisitors_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvApprovedVisitors.Rows[e.RowIndex];
            int detailId = Convert.ToInt32(gvApprovedVisitors.DataKeys[e.RowIndex].Value);

            string name = ((TextBox)row.FindControl("txtName")).Text.Trim();
            string email = ((TextBox)row.FindControl("txtEmail")).Text.Trim();
            string mobile = ((TextBox)row.FindControl("txtMobile")).Text.Trim();
            string department = ((TextBox)row.FindControl("txtDepartment")).Text.Trim();
            string personToMeet = ((TextBox)row.FindControl("txtToMeet")).Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Details 
                                 SET Name = @Name, Email = @Email, Mobile = @Mobile, 
                                     Department = @Department, PersonToMeet = @PersonToMeet 
                                 WHERE DetailId = @DetailId";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@Department", department);
                cmd.Parameters.AddWithValue("@PersonToMeet", personToMeet);
                cmd.Parameters.AddWithValue("@DetailId", detailId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvApprovedVisitors.EditIndex = -1;
            LoadApprovedVisitors(txtSearch.Text.Trim());
        }
    }
}
