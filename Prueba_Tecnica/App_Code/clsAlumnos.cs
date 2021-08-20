using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de clsAlumnos
/// </summary>
public class clsAlumnos
{
    public clsAlumnos()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }
    public static DataTable SelectAlumnos()
    {
        DbCommand comm = clsAccesoDataBase.CreateCommand();
        comm.CommandText = "Select * from Alumnos";
        return clsAccesoDataBase.ExecuteSelectCommand(comm);
    }
    public static DataTable SelectAlumnos(string AlumnoID)
    {
        DbCommand comm = clsAccesoDataBase.CreateCommand();
        comm.CommandText = "SELECT * FROM Alumnos Where AlumnoID=" + AlumnoID;
        return clsAccesoDataBase.ExecuteSelectCommand(comm);
    }

    public static int insertAlumnos(string NombreAlumno, string APaterno, string AMaterno, DateTime Birthdate, string Gender, string GradoActual, string Email, string Telefono)
    {
        string password = clsLogin.EncryptToBase64("9999");
        DbCommand comm = clsAccesoDataBase.CreateCommand();
        comm.CommandText = "INSERT INTO Alumnos (NombreAlumno, APaterno, AMaterno, Birthdate, Gender, GradoActual, Email, Telefono)" +
            "VALUES ('" + NombreAlumno + "','" + APaterno + "','" + AMaterno + "','" + Birthdate.ToString("yyy/MM/dd") + "','" + Gender + "','" + GradoActual + "','" + Email + "','" + Telefono + "')";
        int x = clsAccesoDataBase.ExecuteNonQuery(comm);
        return x;
    }
    public static int updateAlumnos(string AlumnoID, string NombreAlumno, string APaterno, string AMaterno, DateTime Birthdate, string Gender, string GradoActual, string Email, string Telefono)
    {
        DbCommand comm = clsAccesoDataBase.CreateCommand();
        comm.CommandText = "UPDATE Alumnos SET NombreAlumno = '" + NombreAlumno + "', APaterno = '" + APaterno + "', AMaterno = '" + AMaterno + "', Birthdate = '" + Birthdate.ToString("yyy/MM/dd") + "', Gender = '" + Gender + "', GradoActual ='" + GradoActual 
            + "', Email='" + Email + "', Telefono = '" + Telefono + "' where AlumnoID = " + AlumnoID;
        int x = clsAccesoDataBase.ExecuteNonQuery(comm);
        return x;
    }
    public static int deleteAlumnos(string AlumnoID)
    {
        DbCommand comm = clsAccesoDataBase.CreateCommand();
        comm.CommandText = "DELETE From Alumnos" +
            " WHERE AlumnoID=" + AlumnoID;
        int x = clsAccesoDataBase.ExecuteNonQuery(comm);
        return x;
    }
}