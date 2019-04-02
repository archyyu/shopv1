using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Model
{
    public class Order
    {

        public String id { get; set; }

        public String addressid { get; set; }

        public String cardid { get; set; }

        public String account { get; set; }

        public String ordertype { get; set; }

        public String ordertypestr { get; set; }

        public String ordertime { get; set; }

        public String ordertimestr { get; set; }

        public String state { get; set; }

        public String statestr { get; set; }

        public String paytime { get; set; }

        public String totalprice { get; set; }

        public String payprice { get; set; }

        public String discountprice { get; set; }

        public String pointprice { get; set; }

        public String paytype { get; set; }

        public String paytypestr { get; set; }

        public String comment { get; set; }

        public String star { get; set; }

        public String memberid { get; set; }

        public String netbarmemberid { get; set; }

        public String transactionid { get; set; }

        public String visibleflag { get; set; }

        public String logistnumber { get; set; }

        public String des { get; set; }

        public String ip { get; set; }

        public String logisttype { get; set; }

        public String cancelreason { get; set; }

        public String activityid { get; set; }

        public String shopid { get; set; }

        public String productdetail { get; set; }

        public String alert { get; set; }

        public String confirmtime { get; set; }

        public String username { get; set; }

        public String userid { get; set; }

        public String cardprice { get; set; }

        public String walletprice { get; set; }

        public String rechargefee { get; set; }

        public String awardfee { get; set; }

        public String shopId { get; set; }   //水吧id
        public String barName
        {
            get;
            set;
        }  //水吧名称

        public String waiterName
        {
            get;
            set;
        }

        public String casher
        {
            get;
            set;
        }   //收银员
        public String orderId
        {
            get;
            set;
        }  //订单号
        public String orderTime
        {
            get;
            set;
        } //订单时间
        public List<OrderProduct> orderList
        {
            get;
            set;
        }  //订单详情
        public String total
        {
            get;
            set;
        }  //合计
        public String seatNo
        {
            get;
            set;
        } //座位号
        public String qrCodeUrl
        {
            get;
            set;
        }

        public String realName
        {
            get;
            set;
        }//会员名称
        public String discountPrice
        {
            get;
            set;
        }//折扣价格
        public String pointPrice
        {
            get;
            set;
        }//积分抵现
        public String payPrice
        {
            get;
            set;
        }//支付价格
        public String orderType
        {
            get;
            set;
        }//订单类型
        public String payType
        {
            get;
            set;
        }//支付类型

        public String source
        {
            get;
            set;
        }

        public String cardPrice
        {
            get; set;
        }

        public String walletPrice
        {
            get; set;
        }

        public String givingPrice
        {
            get; set;
        }

        public String levelPrice
        {
            get;
            set;
        }
         

        public String remark
        {
            get;
            set;
        }

        public String printCount
        {
            get;
            set;
        }

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
