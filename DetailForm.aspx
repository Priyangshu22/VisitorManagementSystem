<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DetailForm.aspx.cs" Inherits="VMS.DetailForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Visitor Detail Form</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet" />
    <style>
        :root {
            --primary: #127ea0;
            --light-bg: #fff9db;
            --text-dark: #222;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--primary);
            overflow-x: hidden;
            color: #222;
        }

        h3 {
            color: #fff8cc;
            margin-top: 40px;
            text-align: center;
        }

        .form-section {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
         
            padding: 30px;
            margin: 20px auto;
            border-radius: 12px;
            width: 95%;
            max-width: 1200px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .section-title {
            font-size: 22px;
            color: #fff8cc;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .form-label {
            color: #fff;
            font-weight: 500;
        }

        .form-control {
            border-radius: 8px !important;
        }

        .btn-submit {
    background-color: #fff8ce !important; /* Cream color */
    color: #222 !important;               /* Dark text */
    border: 2px solid #222;
    padding: 14px 36px;
    font-size: 18px;
    font-weight: bold;
    border-radius: 40px;
    cursor: pointer;
    margin: 40px auto 0;
    display: block;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    transition: all 0.3s ease-in-out;
}

.btn-submit:hover {
    background-color: #fff8ce;
    transform: scale(1.05);
}



        #previewImage {
            max-width: 150px;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-top: 10px;
            display: none;
        }

        .cloud-wave {
            height: 120px;
            background: url('https://svgshare.com/i/13zT.svg') repeat-x;
            background-size: cover;
            position: relative;
            bottom: -1px;
        }

        @media screen and (max-width: 768px) {
            .section-title {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h3 data-aos="fade-down">Visitor Details</h3>

        <!-- Visitor Section -->
        <div class="form-section" data-aos="fade-up">
            <div class="section-title">Visitor & Visiting Details</div>
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label Text="Mobile No." CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtMobile" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Name" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtName" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Email" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" />
                </div>

                <div class="col-md-4">
                    <asp:Label Text="Visitor Proof" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlProof" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Select" />
                        <asp:ListItem Text="Aadhar" />
                        <asp:ListItem Text="PAN Card" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Proof No." CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtProofNo" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Upload Photo" CssClass="form-label" runat="server" />
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <asp:FileUpload ID="filePhoto" CssClass="form-control" runat="server" Style="width: 70%;" />
                        <img id="previewImage" alt="Preview" style="width: 100px; height: 100px; object-fit: cover; border: 2px solid #fff8cc; border-radius: 10px; display: none;" />
                    </div>
                </div>




                <div class="col-md-3">
                    <asp:Label Text="Visiting Time" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlTimeSlot" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Select a time slot" Value="" />
                        <asp:ListItem Text="9:00 AM - 10:00 AM" />
                        <asp:ListItem Text="10:00 AM - 11:00 AM" />
                        <asp:ListItem Text="11:00 AM - 12:00 PM" />
                        <asp:ListItem Text="12:00 PM - 1:00 PM" />
                        <asp:ListItem Text="1:00 PM - 2:00 PM" />
                        <asp:ListItem Text="2:00 PM - 3:00 PM" />
                        <asp:ListItem Text="3:00 PM - 4:00 PM" />
                        <asp:ListItem Text="4:00 PM - 5:00 PM" />
                        <asp:ListItem Text="5:00 PM - 6:00 PM" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:Label Text="Visiting Purpose" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtPurpose" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-3">
                    <asp:Label Text="Select Department" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlDept" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Select" />
                        <asp:ListItem Text="HR" />
                        <asp:ListItem Text="IT" />
                        <asp:ListItem Text="Admin" />
                        <asp:ListItem Text="CFO" />
                        <asp:ListItem Text="CEO" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:Label Text="Person Name" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtPerson" CssClass="form-control" runat="server" />
                </div>
            </div>
        </div>

        <!-- Material Carried -->
        <div class="form-section" data-aos="fade-up">
            <div class="section-title">Material Carried</div>
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label Text="Select Item" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlItem" CssClass="form-control" runat="server">
                        <asp:ListItem Text="Select" />
                        <asp:ListItem Text="Laptop" />
                        <asp:ListItem Text="Documents" />
                        <asp:ListItem Text="Others" />
                        <asp:ListItem Text="Bags" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Serial Number" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtSerial" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Quantity" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlQty" CssClass="form-control" runat="server">
                        <asp:ListItem Text="1" />
                        <asp:ListItem Text="2" />
                        <asp:ListItem Text="3" />
                        <asp:ListItem Text="4" />
                        <asp:ListItem Text="5+" />
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- Vehicle Details -->
        <div class="form-section" data-aos="fade-up">
            <div class="section-title">Vehicle Details</div>
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:Label Text="With Vehicle?" CssClass="form-label" runat="server" />
                    <asp:DropDownList ID="ddlWithVehicle" CssClass="form-control" runat="server">
                        <asp:ListItem Text="No" />
                        <asp:ListItem Text="Yes" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Vehicle Number" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtVehicleNo" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="License Validity" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtValidity" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Driver Licence Number" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtLicenceNo" CssClass="form-control" runat="server" />
                </div>
                <div class="col-md-4">
                    <asp:Label Text="Vehicle Name" CssClass="form-label" runat="server" />
                    <asp:TextBox ID="txtVehicleName" CssClass="form-control" runat="server" />
                </div>
            </div>
        </div>

        <div class="text-center">
            <asp:Button ID="btnSubmitAll" runat="server" Text="Submit All Details" CssClass="btn btn-submit" OnClick="btnSubmitAll_Click" />
        </div>

        <div class="cloud-wave"></div>
    </form>

    <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 1000 });

        document.addEventListener("DOMContentLoaded", function () {
            const fileUpload = document.getElementById("<%= filePhoto.ClientID %>");
            const previewImage = document.getElementById("previewImage");

            fileUpload.addEventListener("change", function () {
                const file = this.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        previewImage.src = e.target.result;
                        previewImage.style.display = "block";
                    }
                    reader.readAsDataURL(file);
                }
            });
        });
    </script>
</body>
</html>