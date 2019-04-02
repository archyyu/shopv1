using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PcWaterbar.Util
{
    public class IniUtil
    {
        private static string file = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "\\serverip.ini";

        public static Int32 getShopId()
        {
            string shopid = CashierLibrary.Util.IniHelper.INIGetStringValue(IniUtil.file,"AIDA","shopid","0");
            return Int32.Parse(shopid);
        }

        public static void setShopId(int shopid)
        {
            CashierLibrary.Util.IniHelper.INIWriteValue(IniUtil.file,"AIDA","shopid",shopid + "");
        }


    }
}
