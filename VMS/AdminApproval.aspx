<%@ Page Title="Admin Approval" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="AdminApproval.aspx.cs" Inherits="VMS.AdminApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #0b7ba2;
            color: #fff8cc;
            font-family: 'Segoe UI', sans-serif;
        }

        .page-title {
            font-weight: 700;
            font-size: 32px;
            color: #127ea2;
            margin-bottom: 30px;
        }

        .table-hover tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .table td, .table th {
            vertical-align: middle;
        }


        .btn-sm {
            padding: 8px 16px;
            font-size: 14px;
            border-radius: 8px;
            font-weight: bold;
        }

        .btn-success {
            background-color: #fff8cc;
            color: #0b7ba2;
            border: none;
            transition: 0.3s ease;
        }

            .btn-success:hover {
                background-color: #f4e58c;
                color: #0a5674;
                box-shadow: 0 0 12px #fff8cc;
            }

        .btn-danger {
            background-color: #ff6d6d;
            color: #fff;
            border: none;
            transition: 0.3s ease;
        }

            .btn-danger:hover {
                background-color: #ff8b8b;
                box-shadow: 0 0 12px #ff8b8b;
            }

        #lblMessage {
            color: #cfffef;
            font-size: 16px;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .page-title {
                font-size: 24px;
                text-align: center;
            }

            .table thead {
                display: none;
            }

            .table, .table tbody, .table tr, .table td {
                display: block;
                width: 100%;
            }

                .table tr {
                    margin-bottom: 15px;
                    border-bottom: 2px solid #fff8cc;
                    padding: 10px;
                }

                .table td {
                    text-align: left;
                    padding-left: 50%;
                    position: relative;
                }

                    .table td::before {
                        position: absolute;
                        left: 15px;
                        width: 45%;
                        white-space: nowrap;
                        font-weight: bold;
                        color: #fff8cc;
                    }

                    .table td:nth-child(1)::before {
                        content: "Visitor Name";
                    }

                    .table td:nth-child(2)::before {
                        content: "Email";
                    }

                    .table td:nth-child(3)::before {
                        content: "Mobile";
                    }

                    .table td:nth-child(4)::before {
                        content: "Photo";
                    }

                    .table td:nth-child(5)::before {
                        content: "Time";
                    }

                    .table td:nth-child(6)::before {
                        content: "To Meet";
                    }

                    .table td:nth-child(7)::before {
                        content: "Actions";
                    }

            .btn-sm {
                width: 100%;
                margin-bottom: 8px;
            }

            asp\:Image {
                display: block;
                margin: 10px auto;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h3 class="page-title">📝 Pending Visitor Approvals</h3>

        <asp:GridView ID="gvVisitors" runat="server" AutoGenerateColumns="False"
            CssClass="table table-bordered table-hover text-light"
            HeaderStyle-CssClass="table-light text-dark"
            RowStyle-BackColor="transparent"
            OnRowCommand="gvVisitors_RowCommand"
            DataKeyNames="DetailId">

            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Visitor Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />

                <asp:TemplateField HeaderText="Photo">
                    <ItemTemplate>
                        <asp:Image ID="imgPhoto" runat="server"
                            ImageUrl='<%# ResolveUrl(Eval("UploadPhotoPath").ToString()) %>'
                            Width="80px" Height="80px"
                            Style="border-radius: 8px; border: 2px solid #fff8cc;" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="VisitingTime" HeaderText="Time" />
                <asp:BoundField DataField="PersonToMeet" HeaderText="To Meet" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnApprove" runat="server" CommandName="Approve" Text="✔ Approve"
                            CommandArgument='<%# Eval("DetailId") %>' CssClass="btn btn-success btn-sm me-2" />

                        <asp:Button ID="btnReject" runat="server" CommandName="Reject" Text="✖ Reject"
                            CommandArgument='<%# Eval("DetailId") %>' CssClass="btn btn-danger btn-sm" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>

        </asp:GridView>

        <asp:Label ID="Label1" runat="server" CssClass="fw-bold mt-3 d-block" />


        <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold mt-4 d-block"></asp:Label>
    </div>
</asp:Content>
