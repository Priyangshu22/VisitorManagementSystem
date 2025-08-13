<%@ Page Title="Contact Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminContactMessages.aspx.cs" Inherits="VMS.AdminMessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .message-card {
            background: #ffffff;
            color: #000;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 450px;
            width: 100%;
            transition: transform 0.2s ease;
        }

        .message-card:hover {
            transform: scale(1.02);
        }

        .message-header {
            font-weight: bold;
            color: #127ea2;
        }

        .message-body {
            margin-top: 10px;
            white-space: pre-wrap;
        }

        .message-footer {
            margin-top: 15px;
            font-size: 0.9rem;
            color: #666;
        }

        .search-box {
            max-width: 400px;
            margin: 20px auto;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="text-center text-primary mb-4">📬 Contact Messages</h2>

    <div class="search-box text-center">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control mb-2" Placeholder="Search by Name or Email" />
        <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click" />
    </div>

    <asp:Repeater ID="rptMessages" runat="server"  OnItemCommand="rptMessages_ItemCommand">
        <ItemTemplate>
    <div class="message-card">
        <div class="message-header d-flex justify-content-between">
            <div>
                <%# Eval("Name") %> (<%# Eval("Email") %>)
            </div>
            <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="Delete"
                CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Are you sure to delete?');">🗑️</asp:LinkButton>
        </div>

        <div class="message-body"><%# Eval("Message") %></div>

        <div class="message-footer d-flex justify-content-between">
            <span>📅 <%# Eval("SubmittedAt", "{0:dd MMM yyyy hh:mm tt}") %></span>
            <span class='<%# Eval("Status").ToString() == "Unread" ? "badge bg-warning text-dark" : "badge bg-success" %>'>
                <%# Eval("Status") %>
            </span>
        </div>
    </div>
</ItemTemplate>

    </asp:Repeater>
</asp:Content>
