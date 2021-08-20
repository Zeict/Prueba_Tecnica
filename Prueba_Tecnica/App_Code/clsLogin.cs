using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
/// <summary>
/// Descripción breve de clsLogin
/// </summary>
public class clsLogin
{
    public clsLogin()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public static DataTable SelectLogin(string User, string Password)
    {
        DbCommand Comm = clsAccesoDataBase.CreateCommand();
        Comm.CommandText = @"Select * From Users where Username='" + User + "' and Password='" + Password + "'";
        return clsAccesoDataBase.ExecuteSelectCommand(Comm);
    }

    ///////////////// ENCRIPTAR /////////////////////

    const string MinSalt = "HS";
    static string Cryp_Salt = "2210#$";
    static string Semilla_Key = "Zeict";
    private static RijndaelManaged Cryptor()
    {
        byte[] Salt = UTF8Encoding.UTF8.GetBytes(Cryp_Salt + MinSalt);
        Rfc2898DeriveBytes derivedBytes =
        new Rfc2898DeriveBytes(Semilla_Key, Salt, 1000);
        RijndaelManaged cryptor = new RijndaelManaged();
        cryptor.KeySize = 128;
        cryptor.Key = derivedBytes.GetBytes(16);
        cryptor.IV = derivedBytes.GetBytes(16);
        return cryptor;
    }
    public static string EncryptToBase64(string Pwr)
    {
        using (MemoryStream ms = new MemoryStream())
        {
            using (ICryptoTransform encryptor =
            Cryptor().CreateEncryptor())
            {
                using (CryptoStream encrypt = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                {
                    byte[] data = new UTF8Encoding(false).GetBytes(Pwr);
                    encrypt.Write(data, 0, data.Length);
                    encrypt.Close();
                    return Convert.ToBase64String(ms.ToArray());
                }
            }
        }
    }

    public static string DecryptFromBase64(string Pwr)
    {
        byte[] data = Convert.FromBase64String(Pwr);
        using (MemoryStream ms = new MemoryStream())
        {
            using (ICryptoTransform decryptor =
            Cryptor().CreateDecryptor())
            {
                using (CryptoStream decrypt =
                new CryptoStream(ms, decryptor, CryptoStreamMode.Write))
                {
                    decrypt.Write(data, 0, data.Length);
                    decrypt.FlushFinalBlock();
                    return new UTF8Encoding(false).GetString(ms.ToArray());
                }
            }
        }
    }
}