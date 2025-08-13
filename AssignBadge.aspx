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

        .status-label {
            font-weight: bold;
            margin-top: 15px;
            text-align: center;
            display: block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="badge-card">
        <h3>🪪 Assign Badge ID</h3>
        <asp:Label ID="lblVisitorName" runat="server" CssClass="d-block mb-3 text-center text-dark fw-bold" />

        <div class="mb-3">
            <asp:TextBox ID="txtBadgeId" runat="server" CssClass="form-control" placeholder="Enter Badge ID" />
        </div>

        <asp:Button ID="btnConfirmCheckIn" runat="server" Text="Confirm Check-In" CssClass="btn btn-success w-100" OnClick="btnConfirmCheckIn_Click" />
        <asp:Label ID="lblStatus" runat="server" CssClass="status-label text-success" />
    </div>
</asp:Content>
