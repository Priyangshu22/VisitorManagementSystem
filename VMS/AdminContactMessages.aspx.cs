using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class AdminMessages : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadMessages();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadMessages(txtSearch.Text.Trim());
        }

        protected void rptMessages_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "DELETE FROM ContactMessages WHERE Id = @id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadMessages();
            }
        }


        private void LoadMessages(string keyword = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT Id, Name, Email, Message, SubmittedAt, Status 
                         FROM ContactMessages 
                         WHERE (@keyword = '' OR 
                                Name LIKE '%' + @keyword + '%' OR 
                                Email LIKE '%' + @keyword + '%' OR 
                                Message LIKE '%' + @keyword + '%')
                         ORDER BY SubmittedAt DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@keyword", keyword);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptMessages.DataSource = dt;
                rptMessages.DataBind();
            }
        }

    }
}
