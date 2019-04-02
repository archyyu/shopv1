using CashierLibrary.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cashier.Util
{
    public class ServerUtil
    {

        public static String printerName;

        public static string cookPrinter;

        public static string waterbarPrinter;

        public static String labelName;

        public static User currentUser;
        
        public static string VersionCode = "V2.31";

        public static Boolean Debug = false;

        public static String VersionType()
        {
            if (Debug == true)
            {
                return "调试版本";
            }
            else
            {
                return "发布版本";
            }
        }

		public static String ServerAddr = "weixin.10000ja.net";

        public static String YunAddr = "yun.aida58.com";

        public static String loadUrl = "http://" + YunAddr + "/cashier/waterbarview/cashier";

        public static String ClientUrl = "http://" + YunAddr + "/cashier/waterbarview/backside?shopid=";

        public static String PrintRequestUrl =  "http://" + ServerAddr + "/waterbar/printer/requestmsg";

        public static String LoginUrl =         "http://" + ServerAddr + "/waterbar/cashier/user/login";

        public static String LoadNotify =       "http://" + ServerAddr + "/waterbar/cashier/user/loadNotify";
              
        public static String PrintOrder =       "http://" + ServerAddr + "/waterbar/cashier/order/printOrder";

        public static String ConfirmOrderUrl =  "http://" + ServerAddr + "/waterbar/cashier/order/confirmOrder";

        public static String PayOrderUrl =      "http://" + ServerAddr + "/waterbar/cashier/order/payOrder";

        public static String CancelOrderUrl =   "http://" + ServerAddr + "/waterbar/cashier/order/cancelOrder";

		public static String UserStatusUrl=		"http://" + ServerAddr + "/waterbar/cashier/user/userStatus";

		public static Int32 cashierId = 0;
        
        public static String token = "";

        public static Int32 volIndex = 4;

        public static Int32 speedIndex = 2;

        public static Int32 speekerIndex = 1;

        
    }
}
