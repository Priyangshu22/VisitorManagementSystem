<%@ Page Title="Scan QR Code" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ScanQR.aspx.cs" Inherits="VMS.ScanQR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5">
        <h3 class="mb-4">Scan Visitor QR Code</h3>

        <!-- QR Scanner Section -->
        <div id="reader" style="width: 300px;"></div>

        <!-- Hidden textbox to get value from QR -->
        <asp:TextBox ID="txtVisitorId" runat="server" CssClass="form-control my-3" ReadOnly="true" placeholder="Scanned Visitor ID"></asp:TextBox>

        <!-- Validate Button -->
        <asp:Button ID="btnValidate" runat="server" Text="Validate QR" CssClass="btn btn-primary" OnClick="btnValidate_Click" />

        <!-- Result of backend validation -->
        <asp:Label ID="lblResult" runat="server" CssClass="d-block mt-4 fw-bold" EnableViewState="true" />

        <!-- Display full scanned QR content -->
        <p class="scanned-text fw-bold mt-3 text-secondary">Scanned text will appear here...</p>
    </div>

    <script type="text/javascript">
        function startScanner() {
            const html5QrCode = new Html5Qrcode("reader");

            const qrConfig = {
                fps: 10,
                qrbox: { width: 250, height: 250 }
            };

            html5QrCode.start(
                { facingMode: "environment" },
                qrConfig,
                qrCodeMessage => {
                    console.log("QR content:", qrCodeMessage);

                    // Show scanned QR full text
                    document.querySelector(".scanned-text").textContent = qrCodeMessage;

                    // Extract Visitor ID (e.g. "Visitor ID: 4")
                    const idMatch = qrCodeMessage.match(/Visitor ID:\s*(\d+)/);
                    if (idMatch) {
                        const visitorId = idMatch[1];
                        console.log("Extracted ID:", visitorId);

                        // Set ID into ASP.NET TextBox
                        document.getElementById("<%= txtVisitorId.ClientID %>").value = visitorId;

                        // Stop scanner once scanned
                        html5QrCode.stop().then(() => {
                            console.log("Camera stopped.");
                        }).catch(err => {
                            console.error("Failed to stop camera:", err);
                        });
                    } else {
                        console.log("❌ Visitor ID not found in QR.");
                        document.querySelector(".scanned-text").textContent = "Invalid QR format. Visitor ID not found.";
                    }
                },
                errorMessage => {
                    // Optional: console.log("Scan error", errorMessage);
                }
            ).catch(err => {
                console.error("QR scanner start error:", err);
            });
        }

        // Start on page load
        window.addEventListener("load", startScanner);
    </script>
</asp:Content>
