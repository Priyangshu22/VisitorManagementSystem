using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace VMS
{
    public partial class Analytics : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        public string DeptLabels, DeptCounts, WeekLabels, WeekCounts;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDepartmentData();
                LoadWeeklyData();
            }
        }

        private void LoadDepartmentData()
        {
            List<string> labels = new List<string>();
            List<int> counts = new List<int>();

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT Department, COUNT(*) AS Count FROM Details WHERE Status = 'Approved' GROUP BY Department";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    labels.Add(dr["Department"].ToString());
                    counts.Add(Convert.ToInt32(dr["Count"]));
                }
                con.Close();
            }

            DeptLabels = FormatJsArray(labels);
            DeptCounts = FormatJsArray(counts);
        }

        private void LoadWeeklyData()
        {
            List<string> days = new List<string>();
            List<int> counts = new List<int>();

            using (SqlConnection con = new SqlConnection(cs))
            {
                for (int i = 6; i >= 0; i--)
                {
                    string dayLabel = DateTime.Now.AddDays(-i).ToString("dd MMM");
                    days.Add(dayLabel);

                    string query = "SELECT COUNT(*) FROM Details WHERE CAST(createdAt AS DATE) = @date AND Status = 'Approved'";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now.AddDays(-i).Date);
                    con.Open();
                    counts.Add((int)cmd.ExecuteScalar());
                    con.Close();
                }
            }

            WeekLabels = FormatJsArray(days);
            WeekCounts = FormatJsArray(counts);
        }

        private string FormatJsArray<T>(List<T> list)
        {
            StringBuilder sb = new StringBuilder("[");
            foreach (var item in list)
            {
                if (item is string)
                    sb.Append($"\"{item}\",");
                else
                    sb.Append($"{item},");
            }
            if (sb.Length > 1)
                sb.Length--;
            sb.Append("]");
            return sb.ToString();
        }
    }
}
