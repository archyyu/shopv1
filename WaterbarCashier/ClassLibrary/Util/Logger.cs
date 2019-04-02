using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CashierLibrary.Util
{
    public class Logger
    {

        public void info(string info)
        {
            LogHelper.WriteLog(info);
        }
        
    }
}
