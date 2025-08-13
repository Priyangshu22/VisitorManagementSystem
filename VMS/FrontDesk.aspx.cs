using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VMS
{
    public partial class FrontDesk : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string mobile = txtSearchMobile.Text.Trim();
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT DetailId, Name, Email, PersonToMeet, VisitingTime, UploadPhotoPath FROM Details WHERE Mobile = @mobile AND Status = 'Approved'";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@mobile", mobile);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    hdnDetailId.Value = dr["DetailId"].ToString();

                    pnlVisitorDetails.Visible = true;

                    lblVisitorInfo.Text = $"<strong>Name:</strong> {dr["Name"]}<br/>" +
                                          $"<strong>Email:</strong> {dr["Email"]}<br/>" +
                                          $"<strong>To Meet:</strong> {dr["PersonToMeet"]}<br/>" +
                                          $"<strong>Time:</strong> {dr["VisitingTime"]}";

                    string photoFile = dr["UploadPhotoPath"]?.ToString();
                    if (!string.IsNullOrEmpty(photoFile))
                    {
                        imgVisitorPhoto.ImageUrl = photoFile;
                    }
                    else
                    {
                        imgVisitorPhoto.ImageUrl = "~/Visitors/default.png"; 
                    }

                    lblSearchMessage.Text = "";
                }
                else
                {
                    pnlVisitorDetails.Visible = false;
                    lblSearchMessage.Text = "No approved visitor found with that mobile number.";
                }
            }
        }
        protected void btnAssignBadge_Click(object sender, EventArgs e)
        {
            string detailId = hdnDetailId.Value;
            if (!string.IsNullOrEmpty(detailId))
            {
                Response.Redirect($"AssignBadge.aspx?detailId={detailId}");
            }
            else
            {
                lblSearchMessage.Text = "❌ Error: Unable to identify visitor.";
            }
        }




    }
}
