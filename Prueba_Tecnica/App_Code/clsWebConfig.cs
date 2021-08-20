using System.Configuration;

/// <summary>
/// Descripción breve de clsWebConfig
/// </summary>
public class clsWebConfig
{
    private static string dbConnectionString;
    private static string dbProviderName;
    static clsWebConfig()
    {
        dbConnectionString = ConfigurationManager.ConnectionStrings["Connection"].ConnectionString;
        dbProviderName = ConfigurationManager.ConnectionStrings["Connection"].ProviderName;
    }
    public static string DbConnectionString
    {
        get { return dbConnectionString; }
    }

    public static string DbProviderName
    {
        get { return dbProviderName; }
    }
}