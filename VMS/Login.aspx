<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="VMS.Login" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="~/Styles/Login.css" rel="stylesheet" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <div class="inner">
                <h3 style="color: #127ea0">User Login</h3>

                <div class="form-holder">
                    <span class="fa fa-user"></span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Placeholder="Username" />
                </div>

                <div class="form-holder">
                    <span class="fa fa-lock"></span>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" Placeholder="Password" />
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="modal-button" OnClick="btnLogin_Click" />

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" EnableViewState="false" />

                <p style="font-size: 14px; text-align: center; margin-top: 15px; color: #fff8ce;">
    <a href="#" id="forgotPasswordLink" style="color: #2596be; text-decoration: underline;">Forgot password?</a> |
    <a href="Register.aspx" style="color: #2596be; text-decoration: underline;">Register</a>
</p>

            </div>
        </div>

        <div id="forgotPasswordModal" class="modal">
            <div class="modal-content">
                <span class="close-button" id="closeModal">&times;</span>
                <h3 style="margin-bottom: 20px;">Reset Your Password</h3>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your registered email" />
                <asp:Button ID="btnForgot" runat="server" Text="Send Reset Link" CssClass="modal-button" OnClick="btnForgot_Click" />
                <asp:Label ID="lblResetMessage" runat="server" ForeColor="Lime" />
            </div>
        </div>
    </form>

    <script>
        const modal = document.getElementById("forgotPasswordModal");
        const openBtn = document.getElementById("forgotPasswordLink");
        const closeBtn = document.getElementById("closeModal");

        openBtn.onclick = function (e) {
            e.preventDefault();
            modal.style.display = "block";
        };

        closeBtn.onclick = function () {
            modal.style.display = "none";
        };

        window.onclick = function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };
    </script>
</body>
</html>