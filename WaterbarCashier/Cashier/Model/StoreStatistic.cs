using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cashier.Model
{
    public class StoreStatistic
    {
        public String shopId { get; set; }

        public String barName { get; set; }

        public String waiterName { get; set; }

        //总收入
        public String totalPrice { get; set; }

        //总消费
        public String totalConsume { get; set; }

        //水吧非现金交易额
        public String waterbarNotCashPrice { get; set; }

        //网费非现金交易额
        public String netChargeNotCashPrice { get; set; }

        //订单数
        public String totalOrders { get; set; }

        //现金支付交易额
        public String cashPrice { get; set; }

        //现金支付订单数
        public String cashOrders { get; set; }

        //微信支付金额(包含扫码支付)
        public String wechatPrice { get; set; }

        //微信支付订单数(包含扫码支付)
        public String wechatOrders { get; set; }

        //钱包支付金额
        public String walletPrice { get; set; }

        //钱包支付订单数
        public String walletOrders { get; set; }

        //卡劵兑换金额
        public String cardPrice { get; set; }

        //卡劵兑换订单数
        public String cardOrders { get; set; }

        //水吧 积分抵现
        public String waterbarPointPrice { get; set; }

        //水吧 卡劵抵现部分
        public String waterbarCardPrice { get; set; }

        //水吧 钱包优惠金额
        public String waterbarWalletDonatePrice { get; set; }


        //现金支付 网费金额
        public String netChargeCashPrice { get; set; }

        //现金支付 网费订单数
        public String netChargeCashOrders { get; set; }

        //微信支付 网费金额
        public String netChargeWachatPrice { get; set; }

        //微信支付 网费订单数
        public String netChargeWachatOrders { get; set; }

        //钱包支付 网费金额
        public String netChargeWalletPrice { get; set; }

        //钱包支付 网费订单数
        public String netChargeWalletOrders { get; set; }

        //积分兑换 网费金额
        public String netChargePointPrice { get; set; }

        //积分兑换 网费订单数
        public String netChargePointOrders { get; set; }

        //卡劵兑换 网费金额
        public String netChargeCardPrice { get; set; }

        //卡劵兑换 网费订单数
        public String netChargeCardOrders { get; set; }

        //网费充值 钱包支付优惠部分
        public String netChargeWalletDonatePrice { get; set; }

        //网费 赠送
        public String netChargeGivingPrice { get; set; }

        public String walletRechargeWechatPrice { get; set; }

        public String walletRechargeWechatOrders { get; set; }

        public String walletRechargeCashPrice { get; set; }

        public String walletRechargeCashOrders { get; set; }

        public String walletRechargeGivingPrice { get; set; }

        public String time { get; set; }

        public List<ProductRecord> productStatistics { get; set; }

        public List<ProductTypeRecord> productTypeStatistics { get; set; }
    }
}
