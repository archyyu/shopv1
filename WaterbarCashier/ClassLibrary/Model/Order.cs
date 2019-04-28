using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Model
{
    public class Order
    {
        public string id { get; set; }

        public Int64 createtime { get; set; }

        public int orderprice { get; set; }

        public Int64 paytime { get; set; }

        public int paytype { get; set; }

        public int ordersource { get; set; }

        public int ordertype { get; set; }

        public int orderstate { get; set; }

        public string address { get; set; }

        public int shopid { get; set; }

        public string shopname { get; set; }

        public string remark { get; set; }

        public int userid { get; set; }

        public string username { get; set; }

        public int memberid { get; set; }

        public string membername { get; set; }

        public List<OrderProduct> orderList { get; set; }

        public static string sourceStr(int source)
        {
            if (source == 0)
            {
                return "手机端";
            }
            if (source == 1)
            {
                return "客户端";
            }
            if (source == 2)
            {
                return "收银端";
            }
            return "未定义";

        }

    }
}
