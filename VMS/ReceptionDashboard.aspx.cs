using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Serialization; 

namespace VMS
{
    public partial class ReceptionDashboard : System.Web.UI.Page
    {

        protected string ChartDataJson; 

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChartData();
            }
        }

        private void LoadChartData()
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT 
                        CONVERT(date, CheckInTime) AS VisitDate,
                        CASE 
                            WHEN DATEPART(HOUR, CheckInTime) BETWEEN 6 AND 11 THEN 'Morning'
                            WHEN DATEPART(HOUR, CheckInTime) BETWEEN 12 AND 17 THEN 'Afternoon'
                            ELSE 'Evening'
                        END AS TimeSlot,
                        COUNT(*) AS VisitorCount
                    FROM CheckInLog
                    GROUP BY CONVERT(date, CheckInTime),
                             CASE 
                                 WHEN DATEPART(HOUR, CheckInTime) BETWEEN 6 AND 11 THEN 'Morning'
                                 WHEN DATEPART(HOUR, CheckInTime) BETWEEN 12 AND 17 THEN 'Afternoon'
                                 ELSE 'Evening'
                             END
                    ORDER BY VisitDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.Fill(dt);
            }

            var groupedData = new Dictionary<string, Dictionary<string, int>>();

            foreach (DataRow row in dt.Rows)
            {
                string date = Convert.ToDateTime(row["VisitDate"]).ToString("dd MMM");
                string timeSlot = row["TimeSlot"].ToString();
                int count = Convert.ToInt32(row["VisitorCount"]);

                if (!groupedData.ContainsKey(date))
                    groupedData[date] = new Dictionary<string, int>();

                groupedData[date][timeSlot] = count;
            }

            var formatted = groupedData.Select(g => new
            {
                VisitDate = g.Key,  
                Morning = g.Value.ContainsKey("Morning") ? g.Value["Morning"] : 0,
                Afternoon = g.Value.ContainsKey("Afternoon") ? g.Value["Afternoon"] : 0,
                Evening = g.Value.ContainsKey("Evening") ? g.Value["Evening"] : 0
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ChartDataJson = serializer.Serialize(formatted);

        }
    }
}
