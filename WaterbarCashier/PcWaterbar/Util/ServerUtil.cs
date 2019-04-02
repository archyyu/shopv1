using PcWaterbar.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PcWaterbar.Util
{
    class ServerUtil
    {

        public static User currentUser;

        public static Boolean Debug = false;

        public static String VersionCode = "V1.02";

        public static String ServerAddr = "weixin.10000ja.net";

        public static String LoginUrl = "http://" + ServerAddr + "/waterbar/cashier/user/login";
        
    }
}
