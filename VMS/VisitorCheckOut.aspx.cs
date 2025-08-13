using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VMS
{
    public partial class VisitorCheckOut : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string badgeId = txtBadgeId.Text.Trim();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT c.LogId, d.Name, d.Email, d.PersonToMeet, d.UploadPhotoPath, c.CheckInTime
                                 FROM CheckInLog c
                                 JOIN Details d ON c.DetailId = d.DetailId
                                 WHERE c.BadgeId = @badgeId AND c.CheckOutAt IS NULL";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@badgeId", badgeId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    ViewState["LogId"] = dr["LogId"].ToString();
                    lblVisitorInfo.Text = $"👤 <strong>{dr["Name"]}</strong><br/>📧 {dr["Email"]}<br/>🧑‍💼 To Meet: {dr["PersonToMeet"]}<br/>⏱ Check-In At: {Convert.ToDateTime(dr["CheckInTime"]).ToString("dd MMM yyyy hh:mm tt")}";

                    string photo = dr["UploadPhotoPath"]?.ToString();
                    imgPhoto.ImageUrl = string.IsNullOrEmpty(photo) ? "~/Visitors/default.png" :  photo;

                    pnlVisitor.Visible = true;
                    lblMessage.Text = "";
                }
                else
                {
                    pnlVisitor.Visible = false;
                    lblMessage.Text = "❌ No visitor found or already checked out.";
                }
            }
        }

        protected void btnCheckOut_Click(object sender, EventArgs e)
        {
            if (ViewState["LogId"] == null)
            {
                lblMessage.Text = "❌ Error: Visitor record not found.";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "UPDATE CheckInLog SET CheckOutAt = @checkout WHERE LogId = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@checkout", DateTime.Now);
                cmd.Parameters.AddWithValue("@id", ViewState["LogId"].ToString());

                con.Open();
                int rows = cmd.ExecuteNonQuery();

                if (rows > 0)
                {
                    lblMessage.CssClass = "text-success fw-bold d-block text-center";
                    lblMessage.Text = "✅ Visitor successfully checked out.";
                    pnlVisitor.Visible = false;
                    txtBadgeId.Text = "";
                }
                else
                {
                    lblMessage.Text = "❌ Update failed.";
                }
            }
        }
    }
}
