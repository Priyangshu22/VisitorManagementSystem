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

        @media (max-width: 768px) {
            .title {
                font-size: 24px;
            }

            .mb-4.row.g-2 {
                flex-direction: column;
            }

            .mb-4 .col-md-3,
            .mb-4 .col-md-2 {
                width: 100%;
            }

            .btn-search {
                width: 100%;
                margin-top: 5px;
            }

            .table td, .table th {
                font-size: 12px;
                padding: 6px;
            }
        }

        @media (max-width: 576px) {
            .card-table {
                padding: 12px;
            }

            .title {
                font-size: 20px;
            }

            .table td, .table th {
                font-size: 11px;
            }
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
                RowStyle-BackColor="transparent"
                OnRowEditing="gvApprovedVisitors_RowEditing"
                OnRowCancelingEdit="gvApprovedVisitors_RowCancelingEdit"
                OnRowUpdating="gvApprovedVisitors_RowUpdating"
                DataKeyNames="DetailId">

                <Columns>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <%# Eval("Name") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text='<%# Bind("Name") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <%# Eval("Email") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Text='<%# Bind("Email") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <%# Eval("Mobile") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" Text='<%# Bind("Mobile") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Department">
                        <ItemTemplate>
                            <%# Eval("Department") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" Text='<%# Bind("Department") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="To Meet">
                        <ItemTemplate>
                            <%# Eval("PersonToMeet") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtToMeet" runat="server" CssClass="form-control" Text='<%# Bind("PersonToMeet") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="VisitingTime" HeaderText="Time" ReadOnly="true" />
                    <asp:BoundField DataField="createdAt" HeaderText="Approved On" DataFormatString="{0:dd MMM yyyy}" ReadOnly="true" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="✏️ Edit"
                                CssClass="btn btn-sm btn-outline-primary float-end" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div class="d-flex justify-content-end gap-2">
                                <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="💾 Update"
                                    CssClass="btn btn-sm btn-success" />
                                <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="❌ Cancel"
                                    CssClass="btn btn-sm btn-secondary" />
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
