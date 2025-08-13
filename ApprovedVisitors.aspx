<%@ Page Title="Approved Visitors" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ApprovedVisitors.aspx.cs" Inherits="VMS.ApprovedVisitors" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #0b7ba2;
            color: #fff8cc;
            font-family: 'Segoe UI', sans-serif;
        }

        .title {
            font-size: 32px;
            font-weight: bold;
            margin: 40px 0 20px;
            text-align: center;
        }

        .card-table {
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(12px);
        }

        .table thead th {
            background-color: #fff8cc;
            color: #0b7ba2;
        }

        .table td, .table th {
            vertical-align: middle;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .scrollable-table {
            overflow-x: auto;
        }

        .form-control {
            border-radius: 8px;
        }

        .btn-search {
            background-color: #127ea2;
            color: #fff8ce;
            font-weight: bold;
            border: none;
        }

        .btn-search:hover {
            background-color: white;
            color: #0a5674;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="title">✅ Approved Visitors</div>

        <div class="mb-4 row g-2">
            <div class="col-md-3">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by Name, Mobile, or Department" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-search w-100" OnClick="btnSearch_Click" />
            </div>
        </div>

        <div class="card-table scrollable-table">
            <asp:GridView ID="gvApprovedVisitors" runat="server" AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover text-light"
                HeaderStyle-CssClass="table-light text-dark"
                RowStyle-BackColor="transparent">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                    <asp:BoundField DataField="Department" HeaderText="Department" />
                    <asp:BoundField DataField="PersonToMeet" HeaderText="To Meet" />
                    <asp:BoundField DataField="VisitingTime" HeaderText="Time" />
                    <asp:BoundField DataField="createdAt" HeaderText="Approved On" DataFormatString="{0:dd MMM yyyy}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
