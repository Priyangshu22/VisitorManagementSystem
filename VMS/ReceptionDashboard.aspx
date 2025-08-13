<%@ Page Title="Reception Dashboard" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="ReceptionDashboard.aspx.cs" Inherits="VMS.ReceptionDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .dashboard-container {
            padding: 30px;
        }

        .chart-container {
            background: #fff8cc;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
        }

        h2 {
            color: #0b7ba2;
        }

        @media (max-width: 1024px) {
            .dashboard-container {
                padding: 20px;
            }

            .chart-container {
                padding: 16px;
            }

            h2 {
                font-size: 24px;
                text-align: center;
            }

            canvas#visitorChart {
                max-width: 100% !important;
                height: auto !important;
            }
        }

        @media (max-width: 600px) {
            .dashboard-container {
                padding: 15px 10px;
            }

            .chart-container {
                padding: 12px;
                border-radius: 12px;
            }

            h2 {
                font-size: 20px;
                margin-bottom: 10px;
            }

            canvas#visitorChart {
                width: 100% !important;
                height: 300px !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-container">
        <h2>📊 Visitor Summary Dashboard</h2>
        <div class="chart-container">
            <canvas id="visitorChart" height="120"></canvas>
        </div>
    </div>

    <script>
        window.onload = function () {
            const chartData = <%= ChartDataJson %>;

            const labels = chartData.map(item => item.VisitDate);
            const morning = chartData.map(item => item.Morning || 0);
            const afternoon = chartData.map(item => item.Afternoon || 0);
            const evening = chartData.map(item => item.Evening || 0);

            const ctx = document.getElementById('visitorChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Morning',
                            backgroundColor: '#3498db',
                            data: morning
                        },
                        {
                            label: 'Afternoon',
                            backgroundColor: '#f39c12',
                            data: afternoon
                        },
                        {
                            label: 'Evening',
                            backgroundColor: '#2ecc71',
                            data: evening
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Daily Visitor Breakdown'
                        }
                    }
                }
            });
        };
    </script>
</asp:Content>
