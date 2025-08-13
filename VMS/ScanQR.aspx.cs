using System;
using System.Configuration;
using System.Data.SqlClient;

namespace VMS
{
    public partial class ScanQR : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblResult.Text = "";
            }
        }

        protected void btnValidate_Click(object sender, EventArgs e)
        {
            string rawInput = txtVisitorId.Text?.Trim();

            lblResult.Text = "🔍 Raw input: " + rawInput;

            if (string.IsNullOrEmpty(rawInput))
            {
                lblResult.Text += "<br/>❌ Visitor ID is empty.";
                lblResult.CssClass = "text-danger fw-bold";
                return;
            }

            int visitorId;
            if (!int.TryParse(rawInput, out visitorId))
            {
                lblResult.Text += "<br/>❌ Invalid Visitor ID format.";
                lblResult.CssClass = "text-danger fw-bold";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT Name, Status, ExpiryDate FROM Details 
                                 WHERE DetailId = @id AND Status = 'Approved' AND GETDATE() <= ExpiryDate";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", visitorId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string name = reader["Name"].ToString();
                    DateTime expiry = Convert.ToDateTime(reader["ExpiryDate"]);
                    lblResult.Text = $"✅ Visitor ID: {visitorId} <br/>Name: {name} <br/>Status: Approved <br/>Valid Until: {expiry:dd-MM-yyyy}";
                    lblResult.CssClass = "text-success fw-bold";
                }
                else
                {
                    lblResult.Text += "<br/>❌ Invalid or Expired Visitor ID.";
                    lblResult.CssClass = "text-danger fw-bold";
                }
            }
        }
    }
}
