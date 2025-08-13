<%@ Page Title="Analytics" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="VMS.Analytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #0b7ba2;
            color: #fff8cc;
            font-family: 'Segoe UI', sans-serif;
        }

        .analytics-header {
            font-size: 36px;
            font-weight: bold;
            text-align: center;
            margin: 40px 0 20px;
        }

        .card-glass {
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 18px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
        }

        canvas {
            width: 100% !important;
            height: auto !important;
        }

        @media (min-width: 768px) {
            .charts-row {
                flex-direction: row;
                justify-content: space-between;
            }

                .charts-row .card-glass {
                    flex: 1;
                }

            .analytics-header {
                font-size: 36px;
            }
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="analytics-header">📊 Visitor Analytics</div>

        <div class="charts-row">
            <div class="card-glass">
                <h5 class="text-center">By Department</h5>
                <canvas id="deptChart"></canvas>
            </div>
            <div class="card-glass">
                <h5 class="text-center">This Week</h5>
                <canvas id="weekChart"></canvas>
            </div>
        </div>
    </div>

    <script>
        window.onload = function () {
            const deptCtx = document.getElementById('deptChart').getContext('2d');
            new Chart(deptCtx, {
                type: 'bar',
                data: {
                    labels: <%= DeptLabels %>,
                    datasets: [{
                        label: 'Visitors',
                        data: <%= DeptCounts %>,
                        backgroundColor: '#127ea2',
                        borderColor: '#ffffff',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });

            const weekCtx = document.getElementById('weekChart').getContext('2d');
            new Chart(weekCtx, {
                type: 'line',
                data: {
                    labels: <%= WeekLabels %>,
                    datasets: [{
                        label: 'Daily Visitors',
                        data: <%= WeekCounts %>,
                        borderColor: '#fff8cc',
                        backgroundColor: '#127ea2',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.3
                    }]
                },
                options: {
                    scales: {
                        y: { beginAtZero: true }
                    }
                }
            });
        };
    </script>
</asp:Content>
