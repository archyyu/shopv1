using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Util
{
    public class LogHelper
    {

        public static readonly log4net.ILog loginfo = log4net.LogManager.GetLogger("loginfo");

        public static readonly log4net.ILog logerror = log4net.LogManager.GetLogger("logerror");

        public static void WriteLog(string info)
        {
            if (loginfo.IsInfoEnabled)
            {
                Debug.Write(info);
                loginfo.Info(info);
            }
        }
        

        public static void WriteLog(string info, Exception se)
        {
            if (logerror.IsErrorEnabled)
            {
                Debug.Write(info);
                logerror.Error(info, se);
            }
        }
    }
}
