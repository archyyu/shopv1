using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CashierLibrary.Util;
using CashierLibrary.Model;
using Cashier.Model;

namespace Cashier.Util
{
    public class PrinterUtil
    {

        private bool isPrinterOk(string printer)
        {
            if (printer == null || printer == "" || printer == "选择打印机")
            {
                return false;
            }
            return true;
        }

        public void resetLoginInfo()
        {

        }

        public void PrintOrder(Order order, String printer)
        {
            if (this.isPrinterOk(printer) == false)
            {
                return;
            }


            try
            {
                int totallen = 32;
                int namelen = 14;
                int pricelen = 6;
                int numlen = 6;
                int sumlen = 6;

                PrinterHelper.GetInstance().Open(printer);
                PrinterHelper.GetInstance().StartPrint();
                PrinterHelper.GetInstance().Feed(2);
                PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);
                

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("智慧网咖水吧系统"));
                //PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Left);
                PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
                if (order.username != "")
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("服务员：" + order.username));
                }
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("订单号：" + order.id));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("时间：" + order.createtime));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("订单类型：" + order.ordertype));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("支付类型：" + order.paytype));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("订单来自：" + Order.sourceStr((order.ordersource))));

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("姓名:" + order.membername));
                

                PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
                PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);

                PrinterHelper.GetInstance().SetBold(true);
                PrinterHelper.GetInstance().SetFontSize(2);

                if (order.address != "")
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("座位号：" + order.address));
                    PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
                }

                if (order.remark != null && order.remark.Length > 0)
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("备注:" + order.remark));
                    PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
                }

                PrinterHelper.GetInstance().SetBold(false);
                PrinterHelper.GetInstance().SetFontSize(1);



                //PrinterHelper.GetInstance().PrintText(AutoCompleteLine("商品名        单价  数量  金额"));

                if (order.orderList != null && order.orderList.Count > 0)
                {

                    {

                        PrinterHelper.GetInstance().PrintText("(商品详情)");

                        string title = "";

                        title += "商品名";
                        int len = Encoding.GetEncoding("gb2312").GetBytes("商品名").Length;
                        title += this.getSpace(namelen - len);

                        title += "原价";
                        title += this.getSpace(pricelen - Encoding.GetEncoding("gb2312").GetBytes("单价").Length);

                        title += "数量";
                        title += this.getSpace(numlen - Encoding.GetEncoding("gb2312").GetBytes("数量").Length);
                        
                        PrinterHelper.GetInstance().PrintText(AutoCompleteLine(title));

                    }

                    foreach (OrderProduct item in order.orderList)
                    {
                        string line = "";
                        int len = Encoding.GetEncoding("gb2312").GetBytes(item.productname.Trim()).Length;
                        if (len >= namelen)
                        {
                            PrinterHelper.GetInstance().PrintText(AutoCompleteLine(item.productname));
                            line += this.getSpace(namelen);
                        }
                        else
                        {
                            line += item.productname;
                            line += getSpace(namelen - len);
                        }

                        line += item.price;
                        line += this.getSpace(pricelen - Encoding.UTF8.GetBytes(item.price + "").Length);

                        line += item.num;
                        line += this.getSpace(numlen - Encoding.UTF8.GetBytes(item.num + "").Length);
                        

                        PrinterHelper.GetInstance().PrintText(AutoCompleteLine(line));
                    }
                }

                PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("合计：" + order.orderprice));
                


                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("实际支付：" + order.orderprice));

                PrinterHelper.GetInstance().Feed(4);
                PrinterHelper.GetInstance().Cut();
                
                PrinterHelper.GetInstance().EndPrint();
                PrinterHelper.GetInstance().Close();
            }
            catch (Exception ee)
            {
                LogHelper.WriteLog(printer + "打印机错误" + ee.ToString());
            }

        }

        public void PrintProductStatistic(string printer, StoreStatistic record)
        {

            if (this.isPrinterOk(printer) == false)
            {
                return;
            }

            List<ProductRecord> list = record.productStatistics;
            if (list == null)
            {
                return;
            }
            if (list.Count <= 0)
            {
                return;
            }

            List<ProductTypeRecord> typelist = record.productTypeStatistics;

            int totallen = 36;

            int namelen = 12;
            int subprice = 8;
            int productnum = 8;
            int productprice = 8;

            PrinterHelper.GetInstance().Open(printer);
            PrinterHelper.GetInstance().StartPrint();
            PrinterHelper.GetInstance().Feed(2);
            PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("爱达智慧网咖水吧系统"));
            PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("本班次商品销售统计"));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("服务员：" + record.waiterName));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("时间：" + record.time));
            PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));

            int productSum = 0;
            double pricesum = 0;

            {
                string title = "";

                title += "商品";
                int len = Encoding.GetEncoding("gb2312").GetBytes("商品").Length;
                title += this.getSpace(namelen - len);

                title += "单价";
                len = Encoding.GetEncoding("gb2312").GetBytes("单价").Length;
                title += this.getSpace(subprice - len);

                title += "销量";
                len = Encoding.GetEncoding("gb2312").GetBytes("销售").Length;
                title += this.getSpace(productnum - len);

                title += "总计";
                len = Encoding.GetEncoding("gb2312").GetBytes("销售额").Length;
                title += this.getSpace(productprice - len);

                PrinterHelper.GetInstance().PrintText(this.AutoCompleteLine(title));
            }

            foreach (ProductRecord item in list)
            {
                string line = "";
                line += item.name;
                int len = Encoding.GetEncoding("gb2312").GetBytes(item.name).Length;

                if (len >= namelen)
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine(line));
                    line = "";
                    line += getSpace(namelen);
                }
                else
                {
                    line += getSpace(namelen - len);
                }

                line += Convert.ToString(Double.Parse(item.payprice) / 100);
                len = Encoding.GetEncoding("gb2312").GetBytes(Convert.ToString(Double.Parse(item.payprice) / 100)).Length;
                line += this.getSpace(subprice - len);

                line += item.productnum;
                len = Encoding.GetEncoding("gb2312").GetBytes(item.productnum).Length;
                line += this.getSpace(productnum - len);

                productSum += Int32.Parse(item.productnum);

                string price = Convert.ToString(Double.Parse(item.productprice) / 100);

                line += price;
                len = Encoding.GetEncoding("gb2312").GetBytes(price).Length;
                line += this.getSpace(productprice - len);

                pricesum += Double.Parse(price);

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine(line));

            }

            {

                string title = "";
                title += "合计 ";
                title += "商品总销量:" + productSum;
                title += " 销售额:" + pricesum;
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine(title));

            }

            namelen = 12;
            productnum = 10;
            productprice = 10;


            PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("商品分类统计"));
            PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));

            {
                string title = "";

                title += "商品分类";
                int len = Encoding.GetEncoding("gb2312").GetBytes("商品分类").Length;
                title += this.getSpace(namelen - len);

                title += "销售数量";
                len = Encoding.GetEncoding("gb2312").GetBytes("销售数量").Length;
                title += this.getSpace(productnum - len);

                title += "销售额";
                len = Encoding.GetEncoding("gb2312").GetBytes("销售额").Length;
                title += this.getSpace(productprice - len);

                PrinterHelper.GetInstance().PrintText(this.AutoCompleteLine(title));
            }

            foreach (ProductTypeRecord item in typelist)
            {
                string line = "";
                line += item.name;
                int len = Encoding.GetEncoding("gb2312").GetBytes(item.name).Length;
                if (len >= namelen)
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine(line));
                    line = "";
                    line += getSpace(namelen);
                }
                else
                {
                    line += getSpace(namelen - len);
                }

                line += item.productnum;
                len = Encoding.GetEncoding("gb2312").GetBytes(item.productnum).Length;
                line += this.getSpace(productnum - len);

                string price = Convert.ToString(Double.Parse(item.productprice) / 100) + "元";

                line += price;
                len = Encoding.GetEncoding("gb2312").GetBytes(price).Length;
                line += this.getSpace(productprice - len);

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine(line));
            }

            {

                string title = "";
                title += "合计 ";
                title += "商品总销量:" + productSum;
                title += " 销售额:" + pricesum;
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine(title));

            }


            PrinterHelper.GetInstance().PrintText(getSplitStr(totallen));
            PrinterHelper.GetInstance().Feed(4);
            PrinterHelper.GetInstance().Cut();
            PrinterHelper.GetInstance().EndPrint();

        }

        public void printProduct(Order order, String printer, int makeSource)
        {

            if (printer == null)
            {
                return;
            }

            if (printer == "选择打印机")
            {
                return;
            }

            try
            {


                PrinterHelper.GetInstance().Open(printer);
                PrinterHelper.GetInstance().StartPrint();
                PrinterHelper.GetInstance().Feed(2);
                PrinterHelper.GetInstance().SetBold(false);
                PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Left);

                foreach (OrderProduct item in order.orderList)
                {
                    
                    for (int i = 0; i < item.num; i++)
                    {

                        PrinterHelper.GetInstance().PrintText("订单号:" + order.id);
                        PrinterHelper.GetInstance().PrintText("商品名称:" + item.productname);
                        PrinterHelper.GetInstance().PrintText("商品数量:" + 1);
                        PrinterHelper.GetInstance().PrintText("座位号:" + order.address);
                        PrinterHelper.GetInstance().PrintText("时间:" + order.createtime);
                        PrinterHelper.GetInstance().PrintText("备注:" + order.remark);

                        PrinterHelper.GetInstance().Feed(4);
                        PrinterHelper.GetInstance().Cut();
                    }

                }



                PrinterHelper.GetInstance().EndPrint();
                PrinterHelper.GetInstance().Close();
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog("print error",ex);
            }
        }
        
        public void setCashierID(int cashierId)
        {
            ServerUtil.cashierId = cashierId;
        }

        /// <summary>
        /// 开钱箱
        /// </summary>
        public void openCashBox()
        {
            String printer = ServerUtil.printerName;
            if (printer == null || printer == "选择打印机")
            {
                return ;
            }

            PrinterHelper.GetInstance().Open(printer);
            PrinterHelper.GetInstance().StartPrint();
            PrinterHelper.GetInstance().OpenCashBox();

            PrinterHelper.GetInstance().EndPrint();
            PrinterHelper.GetInstance().Close();

            return ;
        }

        public int printRechargeOrder(String account,String name, String time,int cashBalance, int baseBalance, int awardBalance,int payType)
        {
            String printer = ServerUtil.printerName;
            if (printer == null || printer == "选择打印机")
            {
                return -1;
            }

            try
            {

                PrinterHelper.GetInstance().Open(printer);
                PrinterHelper.GetInstance().StartPrint();

                PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine(ServerUtil.currentUser.shopName + "智慧网咖系统"));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员充值"));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("时间:" + time));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("卡号:" + account));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("姓名:" + name));

                if (cashBalance > 0)
                {
                    PrinterHelper.GetInstance().SetBold(true);
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("押金:" + cashBalance + "元"));
                    PrinterHelper.GetInstance().SetBold(false);

                }

                if (baseBalance > 0)
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("充值:" + baseBalance + "元"));
                }

                if (awardBalance > 0)
                {
                    PrinterHelper.GetInstance().PrintText(AutoCompleteLine("赠额:" + awardBalance + "元"));
                }

                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("订单支付类型:" + this.getPayTypeDesc(payType)));

                if (payType == 4)
                {
                    try
                    {
                        PrinterHelper.GetInstance().OpenCashBox();
                    }
                    catch (Exception ex)
                    {
                        LogHelper.WriteLog("print error", ex);
                    }

                }


                PrinterHelper.GetInstance().Feed(4);
                PrinterHelper.GetInstance().Cut();
                PrinterHelper.GetInstance().EndPrint();
                PrinterHelper.GetInstance().Close();

            }
            catch (Exception ex)
            {
                LogHelper.WriteLog("print error", ex);
                return -2;
            }

            return 0;

        }

        public void printActiveUser(String account,String name, String time, int costType)
        {
            String printer = ServerUtil.printerName;
            if (printer == null || printer == "选择打印机")
            {
                return;
            }

            PrinterHelper.GetInstance().Open(printer);
            PrinterHelper.GetInstance().StartPrint();

            PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);

            PrinterHelper.GetInstance().PrintText(AutoCompleteLine(ServerUtil.currentUser.shopName + "智慧网咖系统"));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员激活"));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("激活时间:" + time));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("卡号:" + account));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("姓名:" + name));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("上网类型:" + this.getCostTypeDesc(costType)));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("欢迎您的光临"));

            PrinterHelper.GetInstance().Feed(4);
            PrinterHelper.GetInstance().Cut();
            PrinterHelper.GetInstance().EndPrint();
            PrinterHelper.GetInstance().Close();

        }

        public void printAddUser(String account, String time, String name, String memberType,String userName,String phone,String pwd)
        {

            String printer = ServerUtil.printerName;
            if (printer == null || printer == "选择打印机")
            {
                return;
            }

            PrinterHelper.GetInstance().Open(printer);
            PrinterHelper.GetInstance().StartPrint();

            PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);

            PrinterHelper.GetInstance().PrintText(AutoCompleteLine(ServerUtil.currentUser.shopName + "智慧网咖系统"));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine(memberType + "开卡"));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("开卡时间:" + time));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("手机号:" + phone));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("密码:" + pwd));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员类型:" + memberType));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("管理员:" + userName));
            PrinterHelper.GetInstance().PrintText(AutoCompleteLine("欢迎您的光临"));

            PrinterHelper.GetInstance().Feed(4);
            PrinterHelper.GetInstance().Cut();
            PrinterHelper.GetInstance().EndPrint();
            PrinterHelper.GetInstance().Close();

        }

        public void printSubmitUser(String memberType,String onlineTime, String offLinetime,String userName,String cost,String balance,String adminName)
        {
            String printer = ServerUtil.printerName;
            if (printer == null || printer == "选择打印机")
            {
                return;
            }

            PrinterHelper.GetInstance().Open(printer);
            PrinterHelper.GetInstance().StartPrint();

            PrinterHelper.GetInstance().SetAlignMode(eTextAlignMode.Middle);

            PrinterHelper.GetInstance().PrintText(AutoCompleteLine(ServerUtil.currentUser.shopName + "智慧网咖系统"));

            if (memberType.Equals("1"))
            {
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("临卡结账"));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员:" + userName));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("上机时间:" + onlineTime));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("结账时间:" + offLinetime));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("消费:" + cost));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("押金余额:" + balance));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("管理员:" + adminName));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("欢迎您再次光临"));
            }
            else
            {
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员结账"));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("会员:" + userName));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("上机时间:" + onlineTime));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("结账时间:" + offLinetime));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("消费:" + cost));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("余额:" + balance));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("管理员:" + adminName));
                PrinterHelper.GetInstance().PrintText(AutoCompleteLine("欢迎您再次光临"));
            }
            
            PrinterHelper.GetInstance().Feed(4);
            PrinterHelper.GetInstance().Cut();
            PrinterHelper.GetInstance().EndPrint();
            PrinterHelper.GetInstance().Close();

        }

        public String getSpace(int len)
        {
            string str = "";
            for (int i = 0; i < len; i++)
            {
                str += " ";
            }
            return str;
        }

        public string getSplitStr(int len)
        {
            string result = "";
            for (int i = 0; i < len; i++)
            {
                result += "-";
            }
            return result;
        }

        public String AutoCompleteLine(string str)
        {
            int totallen = 32;
            int len = Encoding.GetEncoding("gb2312").GetBytes(str.Trim()).Length;

            if (len < totallen)
            {
                for (int i = 0; i < totallen - len; i++)
                {
                    str += " ";
                }
            }
            return str;

        }

        private String getSourceTypeDesc(int source)
        {
            switch (source)
            {
                case 1:
                    return "";
                case 2:
                    return "";
                case 3:
                    return "";
                case 4:
                    return "";
            }

            return "未定义";
        }

        private String getPayTypeDesc(int payType)
        {
            switch (payType)
            {
                case 1:
                    return "微信支付";
                case 2:
                    return "积分卡券兑换";
                case 3:
                    return "支付宝支付";
                case 4:
                    return "现金支付";
            }

            return "未定义";
        }

        private String getCostTypeDesc(int costType)
        {

            switch (costType)
            {
                case 1:
                    return "单机-普通";
                case 2:
                    return "单机-包时段";
                case 3:
                    return "单机-包时长";
                case 4:
                    return "包房-普通";
                case 5:
                    return "包房-包时段";
                case 6:
                    return "包房-包时长";
            }

            return "未定义";
        }

    }
}
