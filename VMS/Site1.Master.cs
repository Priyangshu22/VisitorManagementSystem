using System;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.Cookies["Username"] != null)
                {
                    lblUser.Text = "Welcome, " + Request.Cookies["Username"].Value;
                }
                else
                {
                    lblUser.Text = "Welcome, Guest";
                }
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            Session.Clear(); 
            Response.Redirect("~/Default.aspx"); 
        }


        public Label UsernameLabel => lblUser;
    }
}
