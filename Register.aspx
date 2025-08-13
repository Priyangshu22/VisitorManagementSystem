<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="VMS.Register" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Register</title>
    <link href="~/Styles/Register.css" rel="stylesheet" runat="server" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container">


            <div class="right">
                <h2>Create Account</h2>

                <div class="form-group">
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="input" Placeholder="Full Name" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtContact" runat="server" CssClass="input" Placeholder="Contact Number" TextMode="Phone" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" Placeholder="Username" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" Placeholder="Password" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TextMode="Email" Placeholder="Email ID" />
                </div>



                <div class="form-group">
                    <asp:TextBox ID="txtAadhar" runat="server" CssClass="input" Placeholder="Aadhar Number" />
                </div>

                <div class="form-group">
                    <asp:TextBox ID="txtDesignation" runat="server" CssClass="input" Placeholder="Designation" />
                </div>

                <div class="form-group">
                    <label for="filePhoto">Upload Photo:</label>
                    <asp:FileUpload ID="filePhoto" runat="server" CssClass="input" />
                </div>

                <div class="form-group">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />
                </div>
                <div class="form-group">
                    <asp:Label ID="lblStatus" runat="server" ForeColor="Red" CssClass="status-label" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
