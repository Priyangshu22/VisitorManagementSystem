
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VMS
{
    public partial class AssignBadge : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (int.TryParse(Request.QueryString["detailId"], out int detailId))
                {
                    LoadVisitorInfo(detailId);
                    ViewState["detailId"] = detailId;
                }
                else
                {
                    lblStatus.Text = "❌ Invalid visitor.";
                    btnConfirmCheckIn.Enabled = false;
                }
            }
            ddlBadgeType.Attributes.Add("onchange", "updateBadgeColor()");

        }
        protected void ddlBadgeType_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            lblStatus.Text = "";
        }

        private void LoadVisitorInfo(int id)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT Name FROM Details WHERE DetailId = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);
                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    lblVisitorName.Text = "Visitor: " + result.ToString();
                }
                else
                {
                    lblVisitorName.Text = "Visitor not found.";
                    btnConfirmCheckIn.Enabled = false;
                }
            }
        }

        protected void btnConfirmCheckIn_Click(object sender, EventArgs e)
        {
            string badgeId = txtBadgeId.Text.Trim();
            string badgeType = ddlBadgeType.SelectedValue;

            if (string.IsNullOrWhiteSpace(badgeType))
            {
                lblStatus.Text = "❌ Please select a badge type.";
                return;
            }

            if (string.IsNullOrWhiteSpace(badgeId))
            {
                lblStatus.Text = "❌ Please enter a valid Badge ID.";
                return;
            }

            string prefix = "";
            if (badgeType == "Visitor")
                prefix = "V-";
            else if (badgeType == "Maintenance")
                prefix = "M-";
            else if (badgeType == "Trainee")
                prefix = "T-";


            if (!badgeId.StartsWith(prefix))
            {
                lblStatus.Text = $"❌ Badge ID must start with '{prefix}' for {badgeType}.";
                return;
            }

            if (ViewState["detailId"] == null)
            {
                lblStatus.Text = "❌ Visitor ID not found.";
                return;
            }

            int detailId = (int)ViewState["detailId"];

            if (IsBadgeIdExists(badgeId))
            {
                lblStatus.Text = "❌ This Badge ID has already been used.";
                return;
            }

            DateTime checkInTime = DateTime.Now;
            DateTime expiryTime = checkInTime.AddDays(3); 

            using (SqlConnection conn = new SqlConnection(cs))
            {
                string sql = @"INSERT INTO CheckInLog (DetailId, BadgeId, BadgeType, CheckInTime, ExpiryTime)
                               VALUES (@DetailId, @BadgeId, @BadgeType, @CheckInTime, @ExpiryTime)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@DetailId", detailId);
                cmd.Parameters.AddWithValue("@BadgeId", badgeId);
                cmd.Parameters.AddWithValue("@BadgeType", badgeType);
                cmd.Parameters.AddWithValue("@CheckInTime", checkInTime);
                cmd.Parameters.AddWithValue("@ExpiryTime", expiryTime);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    lblStatus.ForeColor = System.Drawing.Color.Green;
                    lblStatus.Text = "✅ Badge assigned and check-in recorded successfully!";
                    lblExpiry.Text = $"Badge valid until: {DateTime.Now.AddDays(3):dd MMM yyyy hh:mm tt}";

                }
                catch (Exception ex)
                {
                    lblStatus.ForeColor = System.Drawing.Color.Red;
                    lblStatus.Text = "❌ Error: " + ex.Message;
                }
            }
            lblPreviewName.Text = "👤 " + lblVisitorName.Text.Replace("Visitor: ", "");
            lblPreviewType.Text = "🏷️ " + badgeType;
            lblPreviewExpiry.Text = $"📅 Valid Until: {expiryTime:dd MMM yyyy hh:mm tt}";
            imgQRCode.ImageUrl = "~/GenerateQR.ashx?data=" + badgeId;
            pnlPreview.Visible = true;

            string cordClass = "";
            if (badgeType == "Visitor")
                cordClass = "cord-visitor";
            else if (badgeType == "Maintenance")
                cordClass = "cord-maintenance";
            else if (badgeType == "Trainee")
                cordClass = "cord-trainee";
            cordStrip.Attributes["class"] = "cord-strip " + cordClass;



        }

        private bool IsBadgeIdExists(string badgeId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM CheckInLog WHERE BadgeId = @badgeId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@badgeId", badgeId);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
    }
}