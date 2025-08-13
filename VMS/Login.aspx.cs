using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace VMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["Username"] != null)
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Default.aspx");
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                StringBuilder result = new StringBuilder();
                foreach (byte b in hash)
                {
                    result.Append(b.ToString("x2"));
                }
                return result.ToString();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ShowAlert("Please enter both username and password.");
                return;
            }

            string hashedPassword = HashPassword(password);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Email, Designation FROM Users WHERE Username = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string email = reader["Email"].ToString();
                    string designation = reader["Designation"].ToString();

                    Session["Username"] = username;
                    Session["Designation"] = designation;

                    HttpCookie userCookie = new HttpCookie("Username");
                    userCookie.Value = username;
                    userCookie.Expires = DateTime.Now.AddHours(1);
                    Response.Cookies.Add(userCookie);

                    if (designation.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("AdminApproval.aspx");
                    }
                    else
                    {
                        Response.Redirect("FrontDesk.aspx");
                    }
                }
                else
                {
                    ShowAlert("Invalid username or password.");
                }
            }
        }

        protected void btnForgot_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                lblResetMessage.Text = "Please enter your email.";
                lblResetMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string token = Guid.NewGuid().ToString();
            DateTime expiry = DateTime.Now.AddMinutes(30);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Email", email);
                int count = (int)checkCmd.ExecuteScalar();

                if (count == 0)
                {
                    lblResetMessage.Text = "Email not found.";
                    lblResetMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string updateQuery = "UPDATE Users SET ResetToken = @Token, TokenExpiry = @Expiry WHERE Email = @Email";
                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@Token", token);
                cmd.Parameters.AddWithValue("@Expiry", expiry);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.ExecuteNonQuery();

                string resetLink = $"http://localhost:1234/ResetPassword.aspx?token={token}";

                try
                {
                    MailMessage mail = new MailMessage();
                    mail.From = new MailAddress("noreply.sarralle@gmail.com", "no-reply@sarralle");
                    mail.To.Add(email);
                    mail.Subject = "Password Reset Request";
                    mail.Body = $"Hello,\n\nPlease click the link below to reset your password:\n\n{resetLink}\n\nNote: This link is valid for 30 minutes.";
                    mail.IsBodyHtml = false;

                    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                    smtp.Credentials = new NetworkCredential("noreply.sarralle@gmail.com", "ybgxunyujfkbdhgs");
                    smtp.EnableSsl = true;
                    smtp.Send(mail);

                    lblResetMessage.Text = "Reset link sent to your email.";
                    lblResetMessage.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception ex)
                {
                    lblResetMessage.Text = "Failed to send email: " + ex.Message;
                    lblResetMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        private void ShowAlert(string message)
        {
            string script = $"alert('{message.Replace("'", "\\'")}');";
            ClientScript.RegisterStartupScript(this.GetType(), "LoginAlert", script, true);
        }
    }
}
