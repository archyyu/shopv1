<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

/**
 * Description of PayService
 *
 * @author YJP
 */
class PayService extends Service {

    //put your code here

    const PAYTYPE_WECHAT_NATIVE = "W01";
    //微信js pay
    const PAYTYPE_WECHAT_JSAPI = "W02";
    //支付宝二维码
    const PAYTYPE_ALI_NATIVE = "A01";
    //阿里js pay
    const PAYTYPE_ALI_JSAPI = "A02";
    const PAYTYPE_UNIONPAY_NATIVE = "U01";

    private $wechatAccount;
    private $shopModel;

    public function __construct() {
        parent::__construct();
        $this->wechatAccount = new \model\WechatAccount();
        $this->shopModel = new \model\Shop();
    }
    
    public function getOrderBody($order){
        $body = "";
        
        $list = json_decode($order['orderdetail'],true);
        
        foreach($list as $key=>$value){
            $body = $value['productname'];
            return $body;
        }
        
    }

    
    public function getPayUrl($order) {

        //TODO
        $wechat = $this->wechatAccount->findWechatAccountByUniacid($order['uniacid']);

        logInfo("orderid:" . $order['id'] . " uniacid:" . $order['uniacid'] . " appid:" . $wechat['allinappid'] . "   cusid:" . $wechat['allincusid'] . "   paykey:" . $wechat['paykey']);

        $params = array();
        $params["cusid"] = $wechat['allincusid'];
        $params["appid"] = $wechat['allinappid'];
        //$params["paykey"] = $wechat["paykey"];
        $params["version"] = '11';
        $params["trxamt"] = $order['orderprice'];
        $params["reqsn"] = $order['id']; //订单号,自行生成

        if ($order['paytype'] == 1) {
            $params["paytype"] = PayService::PAYTYPE_WECHAT_NATIVE;
        } else if ($order['paytype'] == 2) {
            $params["paytype"] = PayService::PAYTYPE_ALI_NATIVE;
        }

        $params["randomstr"] = rand(10000000, 99999999);
        $params["body"] = $this->getOrderBody($order);
        $params["remark"] = "remark";
        //$params["acct"] = "openid";
        $params["limit_pay"] = "no_credit";
        //$params["notify_url"] = urlencode("http://pinshangy.com/web/cashier.php?__uniacid=1&f=notify&do=order");
        $params["notify_url"] = "http://pinshangy.com/web/pay.php";
        $params["sign"] = $this->SignArray($params, $wechat['paykey']); //签名

        $paramsStr = $this->ToUrlParams($params);
        $url = "https://vsp.allinpay.com/apiweb/unitorder/pay";
        $rsp = $this->request($url, $paramsStr);

        $rspArray = json_decode($rsp, true);
        if ($this->validSign($rspArray, $wechat['paykey'])) {

            foreach ($rspArray as $key => $value) {
                logInfo("key:$key,value:$value");
            }

            return $rspArray['payinfo'];
        } else {
            return "";
        }
    }

    public function scanPay($order) {

        //TODO
        $wechat = $this->wechatAccount->findWechatAccountByUniacid($order['uniacid']);

        $params = array();
        $params["cusid"] = $wechat['allincusid'];
        $params["appid"] = $wechat['allinappid'];
        //$params["paykey"] = $wechat["paykey"];
        $params["version"] = '11';
        $params["trxamt"] = $order['orderprice'];
        $params["reqsn"] = $order['id']; //订单号,自行生成

        $params["randomstr"] = rand(10000000, 99999999);
        $params["body"] = $this->getOrderBody($order);
        $params["remark"] = "remark";
        //$params["acct"] = "openid";
        $params["limit_pay"] = "";
        $params["authcode"] = $order["authcode"];
        //$params["notify_url"] = urlencode("http://pinshangy.com/web/cashier.php?__uniacid=1&f=notify&do=order");
        //$params["notify_url"] = "http://pinshangy.com/web/pay.php";
        $params["sign"] = $this->SignArray($params, $wechat['paykey']); //签名

        $paramsStr = $this->ToUrlParams($params);
        $url = "https://vsp.allinpay.com/apiweb/unitorder/scanpay";
        $rsp = $this->request($url, $paramsStr);

        logInfo("rsp:" . $rsp);

        $rspArray = json_decode($rsp, true);
        if ($this->validSign($rspArray, $wechat['paykey'])) {

            foreach ($rspArray as $key => $value) {
                logInfo("key:$key,value:$value");
            }

            if ($rspArray["retcode"] == "SUCCESS") {

                if ($rspArray["trxstatus"] == "0000") {
                    //支付成功
                    return true;
                }
            }

            return false;
        } else {
            return false;
        }
    }

    public function request($url, $params) {
        $ch = curl_init();
        $this_header = array("content-type: application/x-www-form-urlencoded;charset=UTF-8");
        curl_setopt($ch, CURLOPT_HTTPHEADER, $this_header);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); //如果不加验证,就设false,商户自行处理
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        $output = curl_exec($ch);
        curl_close($ch);
        return $output;
    }

    public function getJsapiPay($order, $openid) {
        $wechat = $this->wechatAccount->findWechatAccountByUniacid($order['uniacid']);

        $params = array();
        $params["cusid"] = $wechat['allincusid'];
        $params["appid"] = $wechat['allinappid'];
        //$params["paykey"] = $wechat["paykey"];
        $params["version"] = '11';
        $params["trxamt"] = $order['orderprice'];
        $params["reqsn"] = $order['id']; //订单号,自行生成
        $params['paytype'] = 'W02';
        $params["randomstr"] = rand(10000000, 99999999);
        $params["body"] = $this->getOrderBody($order);
        
        $params["remark"] = "remark";
        //$params["acct"] = "openid";
        $params["limit_pay"] = "";
        $params['acct'] = $openid;
        
        //$params["notify_url"] = urlencode("http://pinshangy.com/web/cashier.php?__uniacid=1&f=notify&do=order");
        $params["notify_url"] = "http://pinshangy.com/web/pay.php";
        $params["sign"] = $this->SignArray($params, $wechat['paykey']); //签名
        
        $paramsStr = $this->ToUrlParams($params);
        $url = "https://vsp.allinpay.com/apiweb/unitorder/pay";
        $rsp = $this->request($url, $paramsStr);
        
        logInfo("jspay rsp:".$rsp);
        
        $rspArray = json_decode($rsp, true);
        $payinfo = json_decode($rspArray["payinfo"], true);
        
        return $payinfo;
        
    }

    public function validSign($array, $appKey) {

        foreach ($array as $key => $value) {
            logInfo("valid sign: key:$key value:$value");
        }

        logInfo("retcode:" . $array["retcode"]);
        if ("SUCCESS" == $array["retcode"]) {
            $signRsp = strtolower($array["sign"]);
            $array["sign"] = "";
            $sign = strtolower($this->SignArray($array, $appKey));
            if ($sign == $signRsp) {
                return true;
            } else {
                logInfo("sign:$sign signRsp:$signRsp");
                return false;
            }
        } else {

            return false;
        }

        return false;
    }

    public function notifyValidSign(array $array, $appkey) {
        $sign = $array['sign'];
        unset($array['sign']);
        $array['key'] = $appkey;
        $mySign = $this->SignArray($array, $appkey);
        logInfo("sign:$sign mysign:$mySign");
        return strtolower($sign) == strtolower($mySign);
    }

    private function SignArray(array $array, $appkey) {
        $array['key'] = $appkey; // 将key放到数组中一起进行排序和组装
        ksort($array);
        $blankStr = $this->ToUrlParams($array);
        logInfo("blackStr:$blankStr");
        $sign = md5($blankStr);
        return $sign;
    }

    private function ToUrlParams(array $array) {
        $buff = "";
        foreach ($array as $k => $v) {
            if ($v != "" && !is_array($v)) {
                $buff .= $k . "=" . $v . "&";
            }
        }

        $buff = trim($buff, "&");
        return $buff;
    }

    /**
     * 校验签名
     * @param array 参数
     * @param unknown_type appkey
     */
//	private function ValidSign(array $array,$appkey){
//		$sign = $array['sign'];
//		unset($array['sign']);
//		$array['key'] = $appkey;
//		$mySign = $this->SignArray($array, $appkey);
//		return strtolower($sign) == strtolower($mySign);
//	}
}
