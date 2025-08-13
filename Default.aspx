<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="VMS.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Visitor Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/aos@2.3.4/dist/aos.css" rel="stylesheet" />
    <style>
        :root {
            --primary: #127ea0;
            --light-bg: #fff9db;
            --text-dark: #222;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            overflow-x: hidden;
            background-color: #0b7ba2;
        }

        header {
            background-color: white;
            color: var(--primary);
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 999;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            border: 2px solid black;
            padding: 4px 10px;
        }

        .login-btn {
            padding: 10px 20px;
            background-color: black;
            color: white !important;
            border: none;
            font-weight: 600;
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.2s ease;
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
        }

        .login-btn:hover {
            background-color: #0b7ba2;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 123, 255, 0.3);
        }

        .hero {
            display: flex;
            flex-wrap: wrap;
            flex-direction: row-reverse; /* Image on left */
            color: #fff8d0;
            padding: 100px 40px 60px;
            align-items: center;
            justify-content: space-around;
            background-color: var(--primary);
            min-height: 100vh;
            position: relative;
        }

        .hero-text {
            max-width: 500px;
        }

        .hero-text h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .hero-text p {
            font-size: 18px;
            line-height: 1.6;
        }

        .checkin-btn {
            margin-top: 20px;
            background: white;
            color: var(--primary);
            border: 2px solid #fff8cc;
            padding: 12px 24px;
            font-size: 16px;
            border-radius: 25px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            transition: 0.3s;
        }

        .checkin-btn:hover {
            background-color: #fff8cc;
        }

        .hero-img img {
            width: 700px;
            max-width: 100%;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            display: block;
        }

        .cloud-wave {
            position: absolute;
            bottom: -1px;
            width: 100%;
            height: 120px;
            background: url('https://svgshare.com/i/13zT.svg') repeat-x;
            background-size: cover;
        }

        .features {
            background-color: var(--light-bg);
            padding: 80px 30px;
            text-align: center;
        }

        .features h2 {
            font-size: 36px;
            color: var(--text-dark);
            margin-bottom: 60px;
        }

        .feature-set {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            margin: 0 auto 60px;
            max-width: 1000px;
            text-align: left;
        }

        .feature-text {
            flex: 1;
            padding: 20px;
        }

        .feature-text h3 {
            margin-bottom: 10px;
            color: var(--primary);
            font-size: 24px;
        }

        .feature-text p {
            font-size: 15px;
            color: #444;
        }

        .feature-img {
            flex: 1;
            display: flex;
            justify-content: center;
            padding: 20px;
        }

        .feature-img img {
            width: 180px;
            height: 180px;
            border-radius: 12px;
            animation: sway 1s ease-in-out infinite alternate;
            transform-origin: top center;
        }

        @keyframes sway {
            0% { transform: rotate(-4deg); }
            100% { transform: rotate(4deg); }
        }

        .dotted-line {
            border-bottom: 2px dotted var(--primary);
            margin: 30px auto 50px;
            width: 70%;
        }

        .contact-form {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .field {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .submit-button {
            padding: 12px;
            background-color: black;
            border: none;
            color: #fff8cc;
            font-size: 16px;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-button:hover {
            background-color: #0e6b8c;
        }

        footer {
            text-align: center;
            background-color: var(--primary);
            color: white;
            padding: 20px;
            font-size: 14px;
        }

        @media screen and (max-width: 768px) {
            .hero, .feature-set {
                flex-direction: column;
                text-align: center;
            }

            .feature-img {
                margin-top: 20px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header data-aos="fade-down">
            <div class="logo">YouVisit</div>
            <nav>
                <asp:Button ID="btnLogin" runat="server" CssClass="login-btn" Text="Login" OnClick="btnLogin_Click" />
            </nav>
        </header>

        <section class="hero">
            <!-- ✅ Image on Left -->
            <div class="hero-img" data-aos="fade-left">
                <img src="Images/profile.jpg" alt="Visitor" />
            </div>
            <!-- ✅ Text on Right -->
            <div class="hero-text" data-aos="fade-right">
                <h1 style="font-size:100px">Visitor</h1>
                <h1 style="font-size:80px">Management</h1>
                <h1 style="font-size:70px">System.</h1>
                <h4 id="animated-heading"></h4>
                <asp:Button ID="btnCheckIn" runat="server" CssClass="checkin-btn" Text="Book An Appointment" OnClick="btnCheckIn_Click" />
            </div>
            <div class="cloud-wave"></div>
        </section>

        <section class="features">
            <h2 data-aos="fade-up">Smart Features</h2>

            <div class="feature-set" data-aos="fade-up">
                <div class="feature-text">
                    <h3>QR Check-in</h3>
                    <p>Touchless entry with fast and secure QR code scanning.</p>
                </div>
                <div class="feature-img">
                    <img src="Images/qr-code.png" alt="QR Code" />
                </div>
            </div>

            <div class="dotted-line"></div>

            <div class="feature-set" data-aos="fade-up">
                <div class="feature-text">
                    <h3>Live Dashboard</h3>
                    <p>Track visitors in real-time with actionable insights.</p>
                </div>
                <div class="feature-img">
                    <img src="Images/admin.png" alt="Dashboard" />
                </div>
            </div>

            <div class="dotted-line"></div>

            <div class="feature-set" data-aos="fade-up">
                <div class="feature-text">
                    <h3>Instant Alerts</h3>
                    <p>Hosts get notified immediately when visitors check-in.</p>
                </div>
                <div class="feature-img">
                    <img src="Images/notification.png" alt="Alerts" />
                </div>
            </div>
        </section>

        <section class="features">
            <h2 data-aos="fade-up">Contact Us</h2>
            <div class="contact-form" data-aos="zoom-in">
                <asp:TextBox ID="txtName" runat="server" CssClass="field" Placeholder="Your Name" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="field" Placeholder="Your Email" TextMode="Email" />
                <asp:TextBox ID="txtMessage" runat="server" CssClass="field" Placeholder="Your Message" TextMode="MultiLine" Rows="4" />
                <asp:Button ID="btnSendMessage" runat="server" Text="Send Message" CssClass="submit-button" OnClick="btnSendMessage_Click" />
            </div>
        </section>

        <footer data-aos="fade-in">
            © 2025 Visitor Management System. All rights reserved.
        </footer>
    </form>

    <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 1000 });

        const heading = document.getElementById("animated-heading");
        const fullText = "Welcome to Sarralle.";
        const shortText = "Welcome! Tap the button below to book your appointment.";
        heading.style.color = "#fff8cc";
        let displayText = fullText;
        let charIndex = 0;
        let typing = true;

        function typeEffect() {
            if (typing) {
                if (charIndex < displayText.length) {
                    heading.innerHTML += displayText.charAt(charIndex);
                    charIndex++;
                    setTimeout(typeEffect, 70);
                } else {
                    typing = false;
                    setTimeout(deleteEffect, 1500);
                }
            }
        }

        function deleteEffect() {
            if (!typing) {
                if (charIndex > 0) {
                    heading.innerHTML = displayText.substring(0, charIndex - 1);
                    charIndex--;
                    setTimeout(deleteEffect, 40);
                } else {
                    typing = true;
                    displayText = (displayText === fullText) ? shortText : fullText;
                    setTimeout(typeEffect, 400);
                }
            }
        }

        typeEffect();
    </script>
</body>
</html>