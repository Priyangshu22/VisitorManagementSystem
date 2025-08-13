using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace VMS
{
    public partial class DetailForm : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.QueryString["token"];
                if (string.IsNullOrEmpty(token))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "fail", "alert('❌ Invalid or missing token.');", true);
                    btnSubmitAll.Enabled = false;
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"SELECT BookId, Name, ContactNumber, Email, TokenExpiry 
                                     FROM Book WHERE Token = @Token";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Token", token);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        DateTime expiry = Convert.ToDateTime(reader["TokenExpiry"]);
                        if (expiry < DateTime.Now)
                        {
                            ScriptManager.RegisterStartupScript(this, GetType(), "fail", "alert('❌ Token expired. Please book again.');", true);
                            btnSubmitAll.Enabled = false;
                        }
                        else
                        {
                            ViewState["BookId"] = reader["BookId"];

                            txtName.Text = reader["Name"].ToString();
                            txtMobile.Text = reader["ContactNumber"].ToString();
                            txtEmail.Text = reader["Email"].ToString();

                            txtName.ReadOnly = true;
                            txtMobile.ReadOnly = true;
                            txtEmail.ReadOnly = true;
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "fail", "alert('❌ Invalid token.');", true);
                        btnSubmitAll.Enabled = false;
                    }
                }
            }
        }

        protected void btnSubmitAll_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["BookId"] == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "fail", "alert('❌ Missing BookId. Token may be invalid.');", true);
                    return;
                }

                int bookId = Convert.ToInt32(ViewState["BookId"]);

                string mobile = txtMobile.Text.Trim();
                string name = txtName.Text.Trim();
                string email = txtEmail.Text.Trim();
                string proofType = ddlProof.SelectedValue;
                string proofNo = txtProofNo.Text.Trim();
                string visitingTime = ddlTimeSlot.SelectedValue;
                string purpose = txtPurpose.Text.Trim();
                string department = ddlDept.SelectedValue;
                string personName = txtPerson.Text.Trim();
                string item = ddlItem.SelectedValue;
                string serial = txtSerial.Text.Trim();
                string qty = ddlQty.SelectedValue;
                string withVehicle = ddlWithVehicle.SelectedValue;
                string vehicleNo = txtVehicleNo.Text.Trim();
                string validity = txtValidity.Text.Trim();
                string licenseNo = txtLicenceNo.Text.Trim();
                string vehicleName = txtVehicleName.Text.Trim();

                string photoPath = "";
                if (filePhoto.HasFile)
                {
                    string folder = Server.MapPath("~/Visitors/");
                    if (!Directory.Exists(folder))
                        Directory.CreateDirectory(folder);

                    string filename = Guid.NewGuid().ToString() + Path.GetExtension(filePhoto.FileName); // Unique filename
                    photoPath = "~/Visitors/" + filename;
                    filePhoto.SaveAs(Path.Combine(folder, filename));
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = @"INSERT INTO Details 
                    (BookId, Mobile, Name, Email, ProofType, ProofNumber, VisitingTime, VisitingPurpose, 
                     Department, PersonToMeet, Item, SerialNumber, Quantity, WithVehicle, 
                     VehicleNumber, LicenseValidity, DriverLicenseNumber, VehicleName, UploadPhotoPath, Status)
                    VALUES 
                    (@BookId, @Mobile, @Name, @Email, @ProofType, @ProofNumber, @VisitingTime, @VisitingPurpose, 
                     @Department, @PersonToMeet, @Item, @SerialNumber, @Quantity, @WithVehicle, 
                     @VehicleNumber, @LicenseValidity, @DriverLicenseNumber, @VehicleName, @UploadPhotoPath, 'Pending')";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@BookId", bookId);
                    cmd.Parameters.AddWithValue("@Mobile", mobile);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@ProofType", proofType);
                    cmd.Parameters.AddWithValue("@ProofNumber", proofNo);
                    cmd.Parameters.AddWithValue("@VisitingTime", visitingTime);
                    cmd.Parameters.AddWithValue("@VisitingPurpose", purpose);
                    cmd.Parameters.AddWithValue("@Department", department);
                    cmd.Parameters.AddWithValue("@PersonToMeet", personName);
                    cmd.Parameters.AddWithValue("@Item", item);
                    cmd.Parameters.AddWithValue("@SerialNumber", serial);
                    cmd.Parameters.AddWithValue("@Quantity", qty);
                    cmd.Parameters.AddWithValue("@WithVehicle", withVehicle);
                    cmd.Parameters.AddWithValue("@VehicleNumber", vehicleNo);
                    cmd.Parameters.AddWithValue("@LicenseValidity", validity);
                    cmd.Parameters.AddWithValue("@DriverLicenseNumber", licenseNo);
                    cmd.Parameters.AddWithValue("@VehicleName", vehicleName);
                    cmd.Parameters.AddWithValue("@UploadPhotoPath", photoPath);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "success", "alert('✅ Details submitted successfully.');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "fail", $"alert('❌ Error: {ex.Message}');", true);
            }
        }
    }
}
