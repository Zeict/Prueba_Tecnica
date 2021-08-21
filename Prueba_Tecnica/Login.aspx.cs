using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    [WebMethod]
    public static string CheckUser(string User, string Password)
    {
        if (User != "" & Password != "")
        {
            string P = clsLogin.EncryptToBase64(Password);
            DataTable T = clsLogin.SelectLogin(User, P);
            if (T.Rows.Count > 0)
            {

                if (P == T.Rows[0]["Password"].ToString())
                {
                    FormsAuthenticationTicket Authticket = new FormsAuthenticationTicket(1,
                    T.Rows[0]["Username"].ToString(), DateTime.Now, DateTime.Now.AddDays(1), false,
                    T.Rows[0]["RolID"].ToString(), FormsAuthentication.FormsCookiePath);

                    string encTicket = FormsAuthentication.Encrypt(Authticket);

                    HttpContext.Current.Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

                    if (T.Rows[0]["RolID"].ToString() == "1")
                    {
                        string Nombre = T.Rows[0]["Name"].ToString() + " " + T.Rows[0]["Lastname"].ToString();

                        HttpContext Context = HttpContext.Current;
                        HttpCookie userInfo = new HttpCookie("UserInfo");
                        userInfo["Name"] = T.Rows[0]["Name"].ToString();
                        userInfo["Name"] = Nombre;
                        userInfo["Rol"] = T.Rows[0]["RolID"].ToString();

                        userInfo.Expires = DateTime.Now.AddDays(1d);
                        Context.Response.Cookies.Add(userInfo);

                        return "1," + T.Rows[0]["Username"].ToString() + "," + Nombre;
                    }
                    else if (T.Rows[0]["RolID"].ToString() == "2")
                    {
                        string Nombre = T.Rows[0]["Name"].ToString() + " " + T.Rows[0]["Lastname"].ToString();
                        return "2," + T.Rows[0]["Username"].ToString() + "," + Nombre;
                    }
                }
            }
            return "504";
        }
        else
            return "504";
    }
}