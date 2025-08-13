using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;

namespace VMS
{
    public partial class Bookin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFullName.Attributes["placeholder"] = "Full Name";
                txtFullName.Attributes["required"] = "required";

                txtEmail.Attributes["placeholder"] = "Email";
                txtEmail.Attributes["required"] = "required";

                txtPhone.Attributes["placeholder"] = "Contact Number";
                txtPhone.Attributes["required"] = "required";

                txtCompany.Attributes["placeholder"] = "Company Name";
                txtCompany.Attributes["required"] = "required";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string contactNumber = txtPhone.Text.Trim();
            string companyName = txtCompany.Text.Trim();
            string status = "Pending";

            Guid token = Guid.NewGuid();
            DateTime expiry = DateTime.Now.AddMinutes(30);

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string query = @"INSERT INTO Book (Name, ContactNumber, Email, CompanyName, Status, Token, TokenExpiry)
                                     VALUES (@Name, @ContactNumber, @Email, @CompanyName, @Status, @Token, @TokenExpiry)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", fullName);
                        cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@CompanyName", companyName);
                        cmd.Parameters.AddWithValue("@Status", status);
                        cmd.Parameters.AddWithValue("@Token", token);
                        cmd.Parameters.AddWithValue("@TokenExpiry", expiry);

                        cmd.ExecuteNonQuery();
                    }
                }

                if (!string.IsNullOrEmpty(email))
                {
                    string baseUrl = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath.TrimEnd('/');
                    string link = $"{baseUrl}/DetailForm.aspx?token={HttpUtility.UrlEncode(token.ToString())}";
                    SendEmail(email, link, true);
                }



                txtFullName.Text = "";
                txtEmail.Text = "";
                txtPhone.Text = "";
                txtCompany.Text = "";

                Response.Write("<script>alert('✅ Appointment booked! Link sent to your email.');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('❌ Error: " + ex.Message.Replace("'", "\\'") + "');</script>");
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
