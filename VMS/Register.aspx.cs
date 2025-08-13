using VMS;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace VMS
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string contact = txtContact.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string email = txtEmail.Text.Trim();
            string aadhar = txtAadhar.Text.Trim();
            string designation = txtDesignation.Text.Trim();  
            string photoPath = "";

            lblStatus.Text = ""; 

            if (string.IsNullOrWhiteSpace(password))
            {
                lblStatus.Text = "❌ Password is required.";
                return;
            }

            if (filePhoto.HasFile)
            {
                try
                {
                    string folder = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);

                    string fileName = Path.GetFileName(filePhoto.FileName);
                    photoPath = "Uploads/" + fileName;
                    string fullPath = Path.Combine(folder, fileName);
                    filePhoto.SaveAs(fullPath);
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "❌ Photo upload failed: " + ex.Message;
                    return;
                }
            }

            string hashedPassword = PasswordHelper.HashPassword(password);
            if (string.IsNullOrEmpty(hashedPassword))
            {
                lblStatus.Text = "❌ Error: Password hashing failed.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connStr))
            {
                lblStatus.Text = "❌ Error: Connection string not found.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("User_Registration", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserId", 0);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Contact", contact);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Aadhar", aadhar);
                cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                cmd.Parameters.AddWithValue("@Designation", designation); 

                try
                {
                    conn.Open();
                    int result = cmd.ExecuteNonQuery();
                    lblStatus.ForeColor = System.Drawing.Color.Green;

                    if (result > 0)
                        lblStatus.Text = "✅ Registered successfully!";
                    else
                        lblStatus.Text = "❌ Registration failed. No rows inserted.";
                }
                catch (SqlException sqlEx)
                {
                    lblStatus.Text = "❌ SQL Error: " + sqlEx.Message;
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "❌ Error: " + ex.Message;
                }
            }
        }
    }
}
