using System;
using System.Collections.Generic;
using System.Linq; 
using System.Text; 
using System.IO; 
using System.Threading.Tasks;

namespace CashierLibrary.Util
{
    public class Config
    {

        private static Config config;

        public static void initConfig()
        {
            StreamReader sr = new StreamReader("config.json", Encoding.Default);
            String line = "";
            String content = "";
            while ((line = sr.ReadLine()) != null)
            {
                content += line;
            }
            config = JsonUtil.DeserializeJsonToObject<Config>(content);

        }
        public static Config get()
        {
            return config;
        }

        public String host { get; set; }

        public String port { get; set; }

        public String version { get; set; }

    }
}
