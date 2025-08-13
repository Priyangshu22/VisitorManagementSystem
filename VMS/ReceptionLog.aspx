<%@ Page Title="Reception Log" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="ReceptionLog.aspx.cs" Inherits="VMS.ReceptionLog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .log-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 25px;
            max-width: 1100px;
            margin: 40px auto;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .badge-status {
            display: inline-block;
            padding: 6px 14px;
            margin: 5px 0;
            border-radius: 12px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            text-align: center;
            line-height: 1.4;
            white-space: nowrap;
        }

        .badge-active {
            background-color: #28a745;
        }

        .badge-soon {
            background-color: #ffc107;
            color: #333;
        }

        .badge-expired {
            background-color: #dc3545;
        }


        .table th, .table td {
            vertical-align: middle !important;
        }

        .form-control {
            max-width: 300px;
            display: inline-block;
            margin-right: 10px;
        }

        .btn-filter {
            padding: 6px 16px;
        }

        @media (max-width: 992px) {
            .log-card {
                padding: 20px;
                margin: 20px auto;
            }

            .form-control {
                width: 100% !important;
                max-width: 100% !important;
                margin-bottom: 10px;
            }

            .btn-filter {
                width: 100%;
                margin-top: 10px;
            }

            .mb-4.text-center {
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .table {
                font-size: 14px;
            }
        }

        @media (max-width: 576px) {
            h3.text-center {
                font-size: 20px;
            }

            .badge-status {
                font-size: 12px;
                padding: 4px 10px;
            }

            .table th,
            .table td {
                font-size: 13px;
                padding: 8px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="log-card">
        <h3 class="text-center text-dark mb-4">🧾 Checked-In Visitors</h3>

        <div class="mb-4 text-center">
            <asp:DropDownList ID="ddlBadgeType" runat="server" CssClass="form-control">
                <asp:ListItem Text="All Types" Value="" />
                <asp:ListItem Text="Visitor" Value="Visitor" />
                <asp:ListItem Text="Maintenance" Value="Maintenance" />
                <asp:ListItem Text="Trainee" Value="Trainee" />
            </asp:DropDownList>

            <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date" />

            <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" CssClass="btn btn-primary btn-filter" OnClick="btnFilter_Click" />
        </div>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
            HeaderStyle-BackColor="#127ea2" HeaderStyle-ForeColor="White">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                <asp:BoundField DataField="PersonToMeet" HeaderText="To Meet" />
                <asp:BoundField DataField="BadgeId" HeaderText="Badge ID" />
                <asp:BoundField DataField="BadgeType" HeaderText="Type" />
                <asp:BoundField DataField="CheckInTime" HeaderText="Check-In Time" DataFormatString="{0:dd MMM yyyy hh:mm tt}" />
                <asp:TemplateField HeaderText="Badge Expiry">
                    <ItemTemplate>
                        <%# Eval("Status") %>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
