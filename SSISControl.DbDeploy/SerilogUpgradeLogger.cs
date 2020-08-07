using DbUp.Engine.Output;
using Serilog;

namespace SSISControl.DbDeploy
{
    public class SerilogUpgradeLogger: IUpgradeLog
    {
        public void WriteInformation(string format, params object[] args)
        {
            Log.Information(string.Format(format, args));
        }

        public void WriteError(string format, params object[] args)
        {
            Log.Error(string.Format(format, args));
        }

        public void WriteWarning(string format, params object[] args)
        {
            Log.Warning(string.Format(format, args));
        }
    }
}
