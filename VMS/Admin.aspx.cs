using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class Admin : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAppointments();
            }
        }

        private void LoadAppointments()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Book where Status = 'Pending'", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int bookId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (e.CommandName == "ApproveApp")
                {
                    string token = Guid.NewGuid().ToString();
                    DateTime expiry = DateTime.Now.AddMinutes(30);

                    SqlCommand updateCmd = new SqlCommand("UPDATE Book SET Status='Approved', Token=@Token, TokenExpiry=@TokenExpiry WHERE BookId=@BookId", conn);
                    updateCmd.Parameters.AddWithValue("@Token", token);
                    updateCmd.Parameters.AddWithValue("@TokenExpiry", expiry);
                    updateCmd.Parameters.AddWithValue("@BookId", bookId);
                    updateCmd.ExecuteNonQuery();

                    SqlCommand emailCmd = new SqlCommand("SELECT Email FROM Book WHERE BookId=@BookId", conn);
                    emailCmd.Parameters.AddWithValue("@BookId", bookId);
                    string email = emailCmd.ExecuteScalar()?.ToString();

                    if (!string.IsNullOrEmpty(email))
                    {
                        string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority);
                        string link = $"{baseUrl}/DetailForm.aspx?token={HttpUtility.UrlEncode(token)}";
                        SendEmail(email, link, true);
                    }

                    ScriptManager.RegisterStartupScript(this, GetType(), "toast", "showToast('Appointment Approved!');", true);
                }
                else if (e.CommandName == "RejectApp")
                {
                    SqlCommand rejectCmd = new SqlCommand("UPDATE Book SET Status='Rejected' WHERE BookId=@BookId", conn);
                    rejectCmd.Parameters.AddWithValue("@BookId", bookId);
                    rejectCmd.ExecuteNonQuery();

                    SqlCommand emailCmd = new SqlCommand("SELECT Email FROM Book WHERE BookId=@BookId", conn);
                    emailCmd.Parameters.AddWithValue("@BookId", bookId);
                    string email = emailCmd.ExecuteScalar()?.ToString();

                    if (!string.IsNullOrEmpty(email))
                    {
                        SendEmail(email, "", false);
                    }

                    ScriptManager.RegisterStartupScript(this, GetType(), "toast", "showToast('Appointment Rejected!');", true);
                }

                LoadAppointments();
            }
        }

        private void SendEmail(string toEmail, string link, bool isApproved)
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(toEmail);
                mail.From = new MailAddress("priyangshup.official@gmail.com", "no-reply@sarralle");
                mail.Subject = isApproved ? "Appointment Approved - Action Required" : "Appointment Rejected";

                if (isApproved)
                {
                    mail.Body = $"<p>Your appointment has been <b>approved</b>.</p>" +
                                $"<p>Please click the link below to complete your visitor details. This link is valid for <b>30 Minutes</b> only:</p>" +
                                $"<p><a href='{link}'>{link}</a></p>";
                }
                else
                {
                    mail.Body = $"<p>We regret to inform you that your appointment has been <b>rejected</b>.</p>" +
                                $"<p>If you believe this is an error, please contact the host.</p>";
                }

                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    Credentials = new NetworkCredential("priyangshup.official@gmail.com", "vhpm vfal srub ydup")
                };

                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "mailfail", $"alert('Email failed: {ex.Message}');", true);
            }
        }
    }
}
