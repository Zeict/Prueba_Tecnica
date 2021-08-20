using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Admin_Alumnos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string Save(string AlumnoID,string NombreAlumno, string APaterno, string AMaterno, DateTime Birthdate, string Gender, string GradoActual, string Email, string Telefono)
    {
        try
        {
            int x = 0;
            if (AlumnoID == null || AlumnoID=="")
            {
                x = clsAlumnos.insertAlumnos(NombreAlumno, APaterno, AMaterno, Birthdate, Gender, GradoActual, Email, Telefono);
            }
            else
            {
                DataTable T = clsAlumnos.SelectAlumnos(AlumnoID);
                if (T.Rows.Count != 0)
                {
                    x = clsAlumnos.updateAlumnos(AlumnoID, NombreAlumno, APaterno, AMaterno, Birthdate, Gender, GradoActual, Email, Telefono);
                }
                
            }
            return x.ToString();
        }
        catch (Exception er)
        {
            return er.ToString();
        }
    }

    [WebMethod]
    public static string Delete(string AlumnoID)
    {
        try
        {
            int x = 0;
            DataTable T = clsAlumnos.SelectAlumnos(AlumnoID);
            if (T.Rows.Count == 0)
            {

            }
            else
            {
                x = clsAlumnos.deleteAlumnos(AlumnoID);
            }
            return x.ToString();
        }
        catch (Exception er)
        {
            return er.ToString();
        }
    }
    [WebMethod]
    public static List<Dictionary<string, object>> getData()
    {
        DataTable dt = clsAlumnos.SelectAlumnos();
        List<Dictionary<string, object>> rows =
            new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();
            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col].ToString());
            }
            rows.Add(row);
        }
        return rows;
    }
}