<%@ Page Title="Visitor Check-Out" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="VisitorCheckOut.aspx.cs" Inherits="VMS.VisitorCheckOut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
    body {
        background-color: #0b7ba2;
        color: #fff8cc;
        font-family: 'Segoe UI', sans-serif;
    }

    .check-card {
        background: rgba(255, 255, 255, 0.07);
        border-radius: 18px;
        padding: 30px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(18px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        max-width: 700px;
        margin: 0 auto;
    }

    .btn-checkout {
        background-color: #117ca5;
        border: 2px solid #fff8cc;
        color: #fff8cc;
        font-weight: 600;
        padding: 12px 5px;
        font-size: 16px;
        border-radius: 8px;
        display: inline-block;
        width: 100%;
        transition: 0.3s ease;
    }

    .btn-checkout:hover {
        background-color: #fff8cc;
        color: #0b7ba2;
    }

    .btn-primary{
        background-color : #117ca5;
    }

    .btn-primary:hover{
        background-color: #fff8ce;
        color : #117ca5;
    }

    .form-control {
        background: white;
        border: 5px solid black;
        color: black;
        border-radius: 10px;
    }

    .form-control::placeholder {
        color: #ddd;
    }

    .visitor-photo {
        border-radius: 12px;
        border: 3px solid #fff8cc;
        box-shadow: 0 0 10px rgba(255, 248, 204, 0.4);
        width: 120px;
        height: 120px;
        object-fit: cover;
    }

    .text-dark {
        color: #000;
    }

    .text-success {
        color: #c0ffd0;
    }

    .text-danger {
        color: #ff7a7a;
    }
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h3 class="text-center mb-4">📤 Visitor Check-Out</h3>
        <div class="check-card">
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger fw-bold d-block text-center mb-2" />
            
            <div class="mb-3">
                <asp:TextBox ID="txtBadgeId" runat="server" CssClass="form-control" placeholder="Enter Badge ID" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary mt-2 w-100" OnClick="btnSearch_Click" />
            </div>

            <asp:Panel ID="pnlVisitor" runat="server" Visible="false">
                <div class="d-flex gap-3 align-items-center mb-3">
                    <asp:Image ID="imgPhoto" runat="server" Width="120" Height="120" CssClass="visitor-photo" />
                    <asp:Label ID="lblVisitorInfo" runat="server" CssClass="fw-bold text-dark" />
                </div>
                <asp:Button ID="btnCheckOut" runat="server" Text="✅ Confirm Check-Out" CssClass="btn btn-checkout w-100" OnClick="btnCheckOut_Click" />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
