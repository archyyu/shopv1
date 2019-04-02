using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cashier.Util
{
    class OrderUtil
    {

        private static List<string> orderList = new List<string>();

        public static void init()
        {
            string orders = IniUtil.orders();
            orderList = new List<string>(orders.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries));
        }

        public static void addOrder(string orderId)
        {
            lock (orderList)
            {
                orderList.Add(orderId);
                while (orderList.Count > 200)
                {
                    orderList.RemoveAt(0);
                }

                string orders = string.Join(",", orderList.ToArray());
                
                IniUtil.setOrders(orders);
            }
        }

        public static bool isOrderIn(string orderId)
        {
            return orderList.Contains(orderId);
        }

    }
}
