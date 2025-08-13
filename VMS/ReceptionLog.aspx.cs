using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace VMS
{
    public partial class ReceptionLog : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCheckIns();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LoadCheckIns();
        }

        private void LoadCheckIns()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        d.Name, 
                        d.Mobile, 
                        d.PersonToMeet, 
                        c.BadgeId, 
                        c.BadgeType, 
                        c.CheckInTime, 
                        c.ExpiryTime,
                        CASE
                            WHEN GETDATE() > c.ExpiryTime THEN 'Expired'
                            WHEN DATEDIFF(HOUR, GETDATE(), c.ExpiryTime) <= 12 THEN 
                                CONCAT('Expiring Soon ', FORMAT(c.ExpiryTime, 'dd MMM hh:mm tt'))
                            ELSE 
                                CONCAT('Active ', FORMAT(c.ExpiryTime, 'dd MMM hh:mm tt'))
                        END AS Status
                    FROM CheckInLog c
                    JOIN Details d ON c.DetailId = d.DetailId
                    WHERE 1 = 1";

                if (!string.IsNullOrWhiteSpace(ddlBadgeType.SelectedValue))
                {
                    query += " AND c.BadgeType = @badgeType";
                }

                if (!string.IsNullOrWhiteSpace(txtDate.Text))
                {
                    query += " AND CONVERT(date, c.CheckInTime) = @date";
                }

                query += " ORDER BY c.CheckInTime DESC";

                SqlCommand cmd = new SqlCommand(query, con);

                if (!string.IsNullOrWhiteSpace(ddlBadgeType.SelectedValue))
                {
                    cmd.Parameters.AddWithValue("@badgeType", ddlBadgeType.SelectedValue);
                }

                if (!string.IsNullOrWhiteSpace(txtDate.Text))
                {
                    cmd.Parameters.AddWithValue("@date", DateTime.Parse(txtDate.Text).Date);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
    }
}
