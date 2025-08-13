<%@ Page Title="Assign Badge" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="AssignBadge.aspx.cs" Inherits="VMS.AssignBadge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .badge-card {
            background-color: #f8f9fa;
            padding: 30px;
            border-radius: 16px;
            max-width: 600px;
            margin: 50px auto;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
        }

        h3 {
            color: #127ea2;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 8px;
        }


        .btn-success {
            background-color: #127ea2;
            color: white;
            font-weight: bold;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
        }

            .btn-success:hover {
                background-color: #0a5c7c;
            }

        .visitor-badge {
            background-color: #ffcccc;
        }

        .maintenance-badge {
            background-color: #ccffcc;
        }

        .trainee-badge {
            background-color: #cce5ff;
        }

        .badge-card {
            padding: 30px;
            border-radius: 16px;
            max-width: 600px;
            margin: 50px auto;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.2);
            background-color: #f8f9fa;
            transition: background-color 0.3s ease-in-out;
        }

        .status-label {
            font-weight: bold;
            margin-top: 15px;
            text-align: center;
            display: block;
        }


        .id-card-header h2 {
            margin: 0;
            font-size: 1.3rem;
            color: #127ea2;
        }

        .id-card-header small {
            color: gray;
            display: block;
            margin-bottom: 10px;
        }

        .id-name {
            font-size: 1.1rem;
            font-weight: bold;
            margin-top: 15px;
            display: block;
        }

        .id-type {
            font-size: 0.95rem;
            color: #666;
            display: block;
            margin-bottom: 10px;
        }

        .id-qr {
            max-width: 150px;
            margin: 10px 0;
        }

        .id-expiry {
            font-size: 0.85rem;
            color: #888;
            margin-top: 5px;
            display: block;
        }



        .cord-visitor {
            background-color: #dc3545;
        }

        .cord-maintenance {
            background-color: #28a745;
        }

        .cord-trainee {
            background-color: #007bff;
        }

        .id-card {
            width: 300px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            margin: 50px auto;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
            text-align: center;
            padding-bottom: 20px;
            position: relative;
        }

        .cord-strip {
            height: 8px;
            width: 100%;
            background-color: #f00;
        }

        .id-card-content {
            padding: 15px 20px;
        }

        .company-name {
            color: #127ea2;
            margin: 10px 0 4px;
            font-size: 20px;
        }

        .badge-title {
            color: gray;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .photo-section {
            margin: 10px 0;
        }

        .photo-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            border: 2px solid #ccc;
        }

        .info-section p {
            margin: 5px 0;
            font-size: 15px;
        }

        .qr-img {
            width: 120px;
            margin-top: 10px;
        }

        .print-btn {
            margin-top: 15px;
            background-color: #0a5c7c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
        }

            .print-btn:hover {
                background-color: #127ea2;
            }

        @media print {
            body * {
                visibility: hidden;
            }

            .id-card, .id-card * {
                visibility: visible;
            }

            .id-card {
                position: absolute;
                left: 0;
                top: 0;
            }
        }

        .cord-visitor {
            background-color: #f44336;
        }

        .cord-maintenance {
            background-color: #4CAF50;
        }

        .cord-trainee {
            background-color: #2196F3;
        }


        @media (max-width: 768px) {
            .badge-card {
                margin: 20px 15px;
                padding: 20px;
            }

            h3 {
                font-size: 20px;
            }

            .form-control, .btn-success {
                font-size: 14px;
            }

            .id-card {
                width: 100%;
                margin: 20px auto;
            }

            .id-qr {
                width: 100px;
            }

            .print-btn {
                width: 100%;
            }
        }

        @media print {
            body * {
                visibility: hidden;
            }

            .id-card, .id-card * {
                visibility: visible;
            }

            .id-card {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="badgeCard" class="badge-card" runat="server">
        <h3>🪪 Assign Badge ID</h3>
        <asp:Label ID="lblVisitorName" runat="server" CssClass="d-block mb-3 text-center text-dark fw-bold" />

        <div class="mb-3">
            <asp:DropDownList ID="ddlBadgeType" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlBadgeType_SelectedIndexChanged">
                <asp:ListItem Text="-- Select Badge Type --" Value="" />
                <asp:ListItem Text="Visitor" Value="Visitor" />
                <asp:ListItem Text="Maintenance" Value="Maintenance" />
                <asp:ListItem Text="Trainee" Value="Trainee" />
            </asp:DropDownList>
        </div>

        <div class="mb-3">
            <asp:TextBox ID="txtBadgeId" runat="server" CssClass="form-control" placeholder="Enter Badge ID (e.g., V-123)" />
        </div>

        <asp:Button ID="btnConfirmCheckIn" runat="server" Text="Confirm Check-In" CssClass="btn btn-success w-100" OnClick="btnConfirmCheckIn_Click" />
        <asp:Label ID="lblStatus" runat="server" CssClass="status-label text-success" />
        <asp:Label ID="lblExpiry" runat="server" CssClass="status-label text-info" />

    </div>
    <asp:Panel ID="pnlPreview" runat="server" CssClass="id-card" Visible="false">
        <div id="cordStrip" runat="server" class="cord-strip"></div>

        <div class="id-card-header">
            <h2>Sarralle</h2>
            <small>Visitor Badge</small>
        </div>

        <div class="id-card-body">
            <asp:Label ID="lblPreviewName" runat="server" CssClass="id-name" />
            <asp:Label ID="lblPreviewType" runat="server" CssClass="id-type" />
            <asp:Image ID="imgQRCode" runat="server" CssClass="id-qr" />
            <asp:Label ID="lblPreviewExpiry" runat="server" CssClass="id-expiry" />
        </div>

        <div class="id-card-footer no-print">
            <asp:Button ID="btnPrint" runat="server" Text="🖨️ Print Badge" CssClass="print-btn" OnClientClick="printCard(); return false;" />
        </div>
    </asp:Panel>





    <script type="text/javascript">
        function updateBadgeColor() {
            var ddl = document.getElementById("<%= ddlBadgeType.ClientID %>");
            var card = document.getElementById("badgeCard");

            switch (ddl.value) {
                case "Visitor":
                    card.style.backgroundColor = "#f8d7da";
                    break;
                case "Maintenance":
                    card.style.backgroundColor = "#d4edda";
                    break;
                case "Trainee":
                    card.style.backgroundColor = "#d1ecf1";
                    break;
                default:
                    card.style.backgroundColor = "#f8f9fa";
                    break;
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            updateBadgeColor();
            document.getElementById("<%= ddlBadgeType.ClientID %>").addEventListener("change", updateBadgeColor);
        });

        function printCard() {
            window.print();
        }

    </script>


</asp:Content>
