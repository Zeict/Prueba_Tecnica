using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Administrator : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lblCerrarSesion_Click(object sender, EventArgs e)
    {
        try
        {
            FormsAuthentication.SignOut();
            Response.Redirect("/Login.aspx");
        }
        catch (Exception er)
        {

        }
    }
}
