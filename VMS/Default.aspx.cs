using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Xml.Linq;

namespace VMS
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void btnCheckIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Bookin.aspx");
        }

        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "INSERT INTO ContactMessages (Name, Email, Message, SubmittedAt) VALUES (@Name, @Email, @Message, @SubmittedAt)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Message", message);
                cmd.Parameters.AddWithValue("@SubmittedAt", DateTime.Now);

                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();

                    ScriptManager.RegisterStartupScript(this, GetType(), "Success", "alert('✅ Message sent successfully!');", true);
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Error", $"alert('❌ Error: {ex.Message}');", true);
                }
            }

            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
        }


        protected void btnEmployee_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeeRegister.aspx");
        }


    }
}
