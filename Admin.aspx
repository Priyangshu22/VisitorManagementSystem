<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Admin.aspx.cs" Inherits="VMS.Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            background-color: #ffffff;
            padding: 30px;
            margin-top: 50px;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
        }

        h3 {
            color: #333;
            font-weight: 600;
            text-align: center;
            margin-bottom: 30px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

            .table thead th {
                background-color: #f1f1f1;
                color: #333;
                font-size: 14px;
                text-align: center;
                padding: 12px;
            }

            .table tbody tr {
                border-bottom: 1px solid #e0e0e0;
            }

                .table tbody tr:hover {
                    background-color: #f9f9f9;
                }

            .table td {
                color: #555;
                text-align: center;
                padding: 12px;
                font-size: 14px;
            }

        .btn-approve {
            background-color: #00c853;
            color: #fff;
            border: none;
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 14px;
            transition: 0.2s ease-in-out;
        }

            .btn-approve:hover {
                background-color: #00b347;
            }

            .btn-approve:disabled {
                background-color: #ccc;
                color: #666;
                cursor: not-allowed;
            }

        #toast {
            visibility: hidden;
            min-width: 280px;
            background-color: #323232;
            color: #fff;
            text-align: center;
            border-radius: 10px;
            padding: 14px;
            position: fixed;
            z-index: 999;
            left: 50%;
            bottom: 40px;
            transform: translateX(-50%);
            font-size: 16px;
            box-shadow: 0px 0px 12px #000;
            transition: 0.5s;
        }

            #toast.show {
                visibility: visible;
                animation: fadein 0.4s, fadeout 0.4s 3.5s;
            }

        @keyframes fadein {
            from {
                bottom: 20px;
                opacity: 0;
            }

            to {
                bottom: 40px;
                opacity: 1;
            }
        }

        @keyframes fadeout {
            from {
                bottom: 40px;
                opacity: 1;
            }

            to {
                bottom: 20px;
                opacity: 0;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h3>Pending Appointments</h3>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
            OnRowCommand="GridView1_RowCommand" DataKeyNames="BookId">
            <Columns>
                <asp:BoundField DataField="BookId" HeaderText="Book ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="ContactNumber" HeaderText="Contact" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Panel runat="server" Visible='<%# Eval("Status").ToString() == "Pending" %>'>
                            <asp:Button ID="btnApprove" runat="server" Text="Approve" CommandName="ApproveApp"
                                CommandArgument='<%# Eval("BookId") %>' CssClass="btn btn-success me-2" />
                            <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="RejectApp"
                                CommandArgument='<%# Eval("BookId") %>' CssClass="btn btn-danger" />
                        </asp:Panel>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div id="toast">✅ Appointment Approved & Link Sent!</div>
    </div>

    <script type="text/javascript">
        function showToast(message = '✅ Appointment Approved & Link Sent!') {
            var x = document.getElementById("toast");
            x.innerText = message;
            x.className = "show";
            setTimeout(function () {
                x.className = x.className.replace("show", "");
            }, 4000);
        }
    </script>
</asp:Content>
