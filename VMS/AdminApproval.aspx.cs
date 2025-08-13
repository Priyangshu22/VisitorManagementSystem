using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class AdminApproval : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadPendingVisitors();
        }

        private void LoadPendingVisitors()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Details WHERE Status = 'Pending'";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvVisitors.DataSource = dt;
                gvVisitors.DataBind();
            }
        }

        protected void gvVisitors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int detailId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Approve")
            {
                UpdateStatus(detailId, "Approved");
                lblMessage.Text = "✅ Visitor approved.";
            }
            else if (e.CommandName == "Reject")
            {
                UpdateStatus(detailId, "Rejected");
                lblMessage.Text = "❌ Visitor rejected.";
            }

            LoadPendingVisitors();
        }

        private void UpdateStatus(int detailId, string status)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Details SET Status = @status WHERE DetailId = @id", con);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@id", detailId);
                con.Open();
                cmd.ExecuteNonQuery();

                
                if (status == "Approved")
                {
                    SqlCommand getCmd = new SqlCommand("SELECT Email, Name, VisitingTime FROM Details WHERE DetailId = @id", con);
                    getCmd.Parameters.AddWithValue("@id", detailId);

                    using (SqlDataReader reader = getCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string email = reader["Email"].ToString();
                            string name = reader["Name"].ToString();
                            string time = reader["VisitingTime"].ToString();

                            SendApprovalEmail(email, name, time);
                        }
                    }
                }
            }
        }

        private void SendApprovalEmail(string toEmail, string visitorName, string visitTime)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("priyangshup.official@gamil.com", "no-reply@sarralle");
                mail.To.Add(toEmail);
                mail.Subject = "Your Appointment is Approved ✅";
                mail.Body = $"Dear {visitorName},\n\nYour visit scheduled at {visitTime} has been approved.\n\nPlease carry your ID and arrive on time.\n\nRegards,\nAdmin Team";
                mail.IsBodyHtml = false;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587); 
                smtp.Credentials = new System.Net.NetworkCredential("priyangshup.official@gmail.com", "vhpm vfal srub ydup");
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "⚠️ Email not sent: " + ex.Message;
            }
        }
    }
}
