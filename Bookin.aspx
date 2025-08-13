<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookin.aspx.cs" Inherits="VMS.Bookin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Book Appointment</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="~/Styles/Bookin.css" rel="stylesheet" runat="server" />
    
</head>
<body>
    <form id="form1" runat="server">
        <div class="hero">
           
            <div class="form-container">
                <h2 style="text-align: center; color: #127ea0; margin-bottom: 25px;">Book Appointment</h2>

                <div class="form-group">
                    <i class="fas fa-user"></i>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
                </div>

                <div class="form-group">
                    <i class="fas fa-envelope"></i>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" Placeholder="Email"></asp:TextBox>
                </div>

                <div class="form-group">
                    <i class="fas fa-phone"></i>
                    <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" CssClass="form-control" Placeholder="Phone"></asp:TextBox>
                </div>

                <div class="form-group">
                    <i class="fas fa-building"></i>
                    <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" Placeholder="Company Name"></asp:TextBox>
                </div>

                <asp:Button ID="btnSubmit" runat="server" Text="Submit Appointment" CssClass="btn-submit" OnClick="btnSubmit_Click" />
            </div>
            <div class="cloud-wave"></div>
        </div>
    </form>
</body>
</html>
