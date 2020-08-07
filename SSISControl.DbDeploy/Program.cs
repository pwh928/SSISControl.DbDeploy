using DbUp;
using Serilog;
using System;
using System.Configuration;
using System.Reflection;

namespace SSISControl.DbDeploy
{
    class Program
    {
        static void Main(string[] args)
        {
            Log.Logger = new LoggerConfiguration()
                .Enrich.FromLogContext()
                .ReadFrom.AppSettings()
                .CreateLogger();

            Log.Information($"Starting Seeding databases");

            PerformUpdate(ConfigurationManager.ConnectionStrings["SSISControl"].ConnectionString);

#if DEBUG
            Console.ReadKey();
#endif
        }

        private static void PerformUpdate(string connectionString)
        {
            var builder = new System.Data.Common.DbConnectionStringBuilder { ConnectionString = connectionString };
            string dbName = (builder["Initial Catalog"] as string);

            Log.Information($"Begin migration - DBname:{dbName}");

            EnsureDatabase.For.SqlDatabase(connectionString);

            var upgrader =
                DeployChanges.To
                    .SqlDatabase(connectionString)
                    .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), script =>
                    {
                        return true;
                    })
                    .LogTo(new SerilogUpgradeLogger())
                    .Build();
            var result = upgrader.PerformUpgrade();
            if (result.Successful)
            {
                Log.Information($"{dbName} database script deployment successful");
            }
            else
            {
                Log.Information($"{dbName} database cript deployment failed");
                throw result.Error;
            }
            Log.Information($"End migration - DbName: {dbName}");
        }

        
    }
}
