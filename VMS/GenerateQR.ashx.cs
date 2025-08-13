using System;
using System.Web;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using QRCoder;

namespace VMS
{
    public class GenerateQR : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            string qrData = context.Request.QueryString["data"];
            if (string.IsNullOrEmpty(qrData))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("Missing QR data.");
                return;
            }

            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(qrData, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            Bitmap bitmap = qrCode.GetGraphic(20);
            MemoryStream ms = new MemoryStream();

            bitmap.Save(ms, ImageFormat.Png);
            context.Response.ContentType = "image/png";
            context.Response.BinaryWrite(ms.ToArray());

            ms.Dispose();
            bitmap.Dispose();
            qrCode.Dispose();
            qrCodeData.Dispose();
            qrGenerator.Dispose();
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
