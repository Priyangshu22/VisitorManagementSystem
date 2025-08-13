<%@ Page Title="Visitor Check-In" Language="C#" MasterPageFile="~/Site2.Master" AutoEventWireup="true" CodeBehind="FrontDesk.aspx.cs" Inherits="VMS.FrontDesk" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #0b7ba2;
            color: #fff8cc;
            font-family: 'Segoe UI', sans-serif;
        }

        .checkin-card {
            background: rgba(255, 255, 255, 0.07);
            border-radius: 18px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(18px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            max-width: 700px;
            margin: 0 auto;
        }

        h3 {
            font-size: 36px;
            color: #127ea2;
            margin-bottom: 10px;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            color: #127ea2;
            font-size: 16px;
            margin-bottom: 30px;
        }

        h5 {
            color: #127ea2;
            font-size: 20px;
            margin-top: 20px;
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

        .btn-primary {
            background-color: black;
            border: 2px solid #fff8cc;
            color: #fff8cc;
            font-weight: 600;
            transition: 0.3s ease;
        }

            .btn-primary:hover {
                background-color: #fff8cc;
                color: #0b7ba2;
            }

        .btn-success {
            background-color: #107fa4;
            color: #fff8ce;
            font-weight: 600;
            border: none;
            transition: 0.3s ease;
            padding: 12px 24px;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

            .btn-success:hover {
                background-color: #f4e58c;
                color: #0a5674;
            }

        .text-dark {
            color: black;
        }

        .text-success {
            color: #c0ffd0;
        }

        .text-danger {
            color: #ff7a7a;
        }

        .visitor-info-box {
            background-color: #f8f9fa;
            border: 2px solid #0b7ba2;
            border-radius: 12px;
            padding: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

            .visitor-info-box img {
                object-fit: cover;
                border: 2px solid #0b7ba2;
            }

        @media screen and (max-width: 768px) {
            h3 {
                font-size: 24px;
            }

            .checkin-card {
                padding: 20px;
                margin: 0 10px;
            }

            .visitor-info-box {
                flex-direction: column;
                text-align: center;
            }

                .visitor-info-box img {
                    width: 150px !important;
                    height: 150px !important;
                    margin-bottom: 15px;
                }

            .btn-success {
                width: 100%;
                justify-content: center;
                font-size: 15px;
            }

            .input-group {
                flex-direction: column;
                gap: 10px;
            }

            .form-control {
                width: 100%;
            }

            .btn-primary {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h3 data-aos="fade-down">🏷 Visitor Check-In</h3>
        <p class="subtitle">Please verify the visitor’s identity before confirming check-in.</p>

        <div class="checkin-card" data-aos="fade-up">
            <asp:Label ID="lblSearchMessage" runat="server" CssClass="text-danger fw-bold d-block mb-2 text-center"></asp:Label>

            <div class="input-group mb-4">
                <asp:TextBox ID="txtSearchMobile" runat="server" CssClass="form-control" placeholder="Search by Mobile" />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            </div>

            <asp:Panel ID="pnlVisitorDetails" runat="server" Visible="false">
                <div class="visitor-info-box d-flex align-items-start">
                    <asp:Image ID="imgVisitorPhoto" runat="server" Width="200" Height="200" CssClass="me-3 rounded" ImageUrl="~/Visitors/default.png" />

                    <div>
                        <h5 class="fw-bold mb-2">👤 Visitor Information</h5>
                        <asp:Label ID="lblVisitorInfo" runat="server" CssClass="d-block text-dark mb-1 fw-bold"></asp:Label>
                        <asp:HiddenField ID="hdnDetailId" runat="server" />
                        <asp:Button ID="btnAssignBadge" runat="server" Text="Assign Badge" CssClass="btn btn-success mt-3" OnClick="btnAssignBadge_Click" />

                    </div>
                </div>

            </asp:Panel>

        </div>
    </div>
</asp:Content>
