using System;
using System.Data;
using System.Data.Common;

/// <summary>
/// Descripción breve de clsAccesoDataBase
/// </summary>
public class clsAccesoDataBase
{
    public static DataTable ExecuteSelectCommand(DbCommand command)
    {
        DataTable table;
        try
        {
            command.Connection.Open();
            DbDataReader reader = command.ExecuteReader();
            table = new DataTable();
            table.Load(reader);
            reader.Close();
        }
        catch (Exception ex)
        {
            //clsUtilities.LogError(ex);
            throw;
        }
        finally
        {
            command.Connection.Close();
        }
        return table;
    }
    public static DbCommand CreateCommand()
    {
        string dataProviderName = clsWebConfig.DbProviderName;
        string connectionString = clsWebConfig.DbConnectionString;
        DbProviderFactory factory = DbProviderFactories.
        GetFactory(dataProviderName);
        DbConnection conn = factory.CreateConnection();
        conn.ConnectionString = connectionString;
        DbCommand comm = conn.CreateCommand();
        return comm;
    }

    public static int ExecuteNonQuery(DbCommand command)
    {
        int affectedRows = -1;
        try
        {
            command.Connection.Open();
            affectedRows = command.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            throw;
        }
        finally
        {
            command.Connection.Close();
        }
        return affectedRows;
    }
    public static string ExecuteScalar(DbCommand command)
    {
        string value = "";
        try
        {
            command.Connection.Open();
            value = command.ExecuteScalar().ToString();
        }
        catch (Exception ex)
        {
            throw;
        }
        finally
        {
            command.Connection.Close();
        }
        return value;
    }
}