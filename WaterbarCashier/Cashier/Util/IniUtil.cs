using CashierLibrary.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cashier.Util
{
    public class IniUtil
    {

        public static string file =  AppDomain.CurrentDomain.BaseDirectory + "/config.ini";

        public string getByKey(string key)
        {
            return IniHelper.INIGetStringValue(IniUtil.file,"Set",key,"");
        }

        public void setValue(string key, string value)
        {
            IniHelper.INIWriteValue(IniUtil.file,"Set",key,value);
        }
        

        public static string radiohost()
        {
            string host = IniHelper.INIGetStringValue(IniUtil.file,"Cashier","radiohost","");
            return host;
        }

        public static bool setRadiohost(string radiohost)
        {
            return IniHelper.INIWriteValue(IniUtil.file,"Cashier","radiohost",radiohost);
        }

        public static string oldcashierip()
        {
            return IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "oldcashierip", "");
        }

        public static void setOldcashierip(string ip)
        {
            IniHelper.INIWriteValue(IniUtil.file,"Cashier","oldcashierip",ip);
        }

        public static string version()
        {
            string version = IniHelper.INIGetStringValue(IniUtil.file,"Cashier","version","");
            return version;
        }

        public static string key()
        {
            string key = IniHelper.INIGetStringValue(IniUtil.file,"Cashier","key","");
            return key;
        }

        public static bool setKey(string key)
        {
            return IniHelper.INIWriteValue(IniUtil.file,"Cashier","key",key);
        }

        public static bool setOrders(string orders)
        {
            return IniHelper.INIWriteValue(IniUtil.file,"Cashier","orders",orders);
        }

        public static string orders()
        {
            return IniHelper.INIGetStringValue(IniUtil.file,"Cashier","orders","");
        }

    }
}
