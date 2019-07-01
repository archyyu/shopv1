<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

use common\OrderType;
use model\ShopMemberCard;
use service\WechatService;

/**
 * Description of OrderController
 *
 * @author YJP
 */
class OrderController extends \controller\Controller{
    
    private $orderService;
    
    private $payService;
    
    private $orderModel;
    
    private $productTypeModel;
    
    private $wechatModel;
    
    private $redisService;
    
    private $memberModel;

    private $cardModel;
    
    public function __construct() {
        parent::__construct();
        $this->productTypeModel = new \model\ShopProductType();
        $this->orderService = new \service\OrderService();
        $this->payService = new \service\PayService();
        $this->orderModel = new \model\ShopOrder(); 
        $this->wechatModel = new \model\WechatAccount();
        $this->redisService = new \service\RedisService();
        $this->memberModel = new \model\ShopMember();
        $this->cardModel = new ShopMemberCard();
    }
    
    public function createOrder(){
        
        $memberid = $this->getParamDefault("memberid",0);
        $userid = $this->getParamDefault("userid", 0);
        $shopid = $this->getParam("shopid");
        $address = $this->getParamDefault("address", "A001");
        $ordersource = $this->getParam("from");
        $remark = $this->getParamDefault('remark','');
        $paytype = $this->getParam("paytype");
        $membercardid = $this->getParamDefault("membercardid",0);
        $uniacid = $this->getUniacid();
        $phone = $this->getParam("phone");

        $password = $this->getParam("password");

        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);

        if ($paytype == 5) {
            //
            $data = $this->orderService->payByAccount($memberid, $uniacid, $shopid, $address, 
                $productlist, $ordersource, $remark, $membercardid, $password);

            if ($data['result'] == false) {
                $this->returnFail($data['info']);
            }
            else{
                $this->returnSuccess();
            }

            return ;

        }
        
        if(isset($phone)){
            //TODO
            $member = $this->memberModel->quertyMember($uniacid, $phone);
            if(isset($member)){
                $memberid = $member["uid"];
            }
        }
        
        if(isset($uniacid) == false){
            $uniacid = $this->shopModel->findShopById($shopid)['uniacid'];
        }
        
        // $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        $orderid = $this->orderService->generateProductOrder($uniacid,$memberid, $userid, $shopid, 
                $address, $productlist, $ordersource, $remark,$paytype,$membercardid);
        
        if($orderid == false){
            $this->returnFail("订单错误");
        }
        
        if($ordersource == 0 && $paytype == 0){
            $this->orderService->payOrder($shopid, $orderid);
        }
        
        if($paytype == 1 || $paytype == 2){
            
            $order = $this->orderModel->findOrderById($orderid);
            
            $payurl = $this->payService->getPayUrl($order);
            
            $result = array();
            $result['orderid'] = $orderid;
            $result["payurl"] = $payurl;
            
            $this->returnSuccess($result);
        }
        
        //扫码枪
        if($paytype == 3){

            $data = array();
            $data["paytype"] = OrderType::AliPay;
            $this->orderModel->saveOrder($data, $orderid);

        }
        
        $result = array();
        $result["orderid"] = $orderid;
        
        $this->returnSuccess($result);
        
    }
    
    public function scanPay(){
        
        $orderid = $this->getParam("orderid");
        $code = $this->getParam("code");
        
        $order = $this->orderModel->findOrderById($orderid);
        $order["authcode"] = $code;
        $result = $this->payService->scanPay($order);
        
        
        
        $data = array();
        $data["authcode"] = $code;
        if($result == 0){


            $this->orderService->payOrder($order["shopid"],$orderid);

        }
        //
        
        $this->returnSuccess($result);
        
    }
    
    public function payOrder(){
        
    }

    public function completeOrder(){

        $shopid = $this->getParam("shopid");
        $orderid = $this->getParam("orderid");

        $order = $this->orderModel->findOrderById($orderid);

        if($order["orderstate"] == 0){

            $data = array();
            $data["orderstate"] = 1;

            $this->orderModel->saveOrder($data,$orderid);

            if(isset($order["memberid"])){
                (new WechatService)->sendNoticeByUid($order["memberid"], "您的订单号为$orderid 的订单已经确认", $order["uniacid"]);
            }


            $this->returnSuccess();

        }
        else{
            $this->returnFail("订单已经确认过");
        }

    }
    
    public function notify(){
        //global $_POST;
        foreach($_POST as $key=>$value){
            logInfo("notify--key:$key value:$value");
        }
        
        $params = array();
        foreach($_POST as $key=>$val) {//动态遍历获取所有收到的参数,此步非常关键,因为收银宝以后可能会加字段,动态获取可以兼容由于收银宝加字段而引起的签名异常
            $params[$key] = $val;
        }
        
        unset($params["paykey"]);
        unset($params["paytype"]);
        
        $orderid = $params["outtrxid"];
        $order = $this->orderModel->findOrderById($orderid);
        
        $wechat = $this->wechatModel->findWechatAccountByUniacid($order["uniacid"]);
        
        //unset($params["signtype"]);
        $result = $this->payService->notifyValidSign($params, $wechat["paykey"]);
        if($result){
            
            if($order["orderstate"] >= 0){
                exit("success");
            }

            if($order['ordertype'] == OrderType::ChargeOrder){
            	$this->orderService->payChargeOrder($orderid);
			}
            else if($order['ordertype'] == OrderType::ProductOrder){
				$this->orderService->payOrder($order['shopid'], $orderid);
			}

            exit("success");
        }
        else{
            exit("error");
        }
    }
    
    public function queryOrderState(){
        
        $orderid = $this->getParam("orderid");
        
        $order = $this->orderModel->findOrderById($orderid);
        
        if(isset($order["authcode"])){
            
            $result = $this->payService->queryOrderState($order);
            //$this->returnSuccess($result);
            if($result == 0){
                $this->orderService->payOrder($order["shopid"], $orderid);
                $this->returnSuccess(0);
            }
            else{
                $this->returnFail("");
            }
            
        }
        else{

            $this->returnSuccess($order['orderstate']);

        }
        
    }
    
    public function cashierQueryOrder(){
        
        $shopid = $this->getParam("shopid");
        $starttime = $this->orderService->queryLastDutyTime($shopid);
        $endtime = time();
        
        $orderList = $this->orderModel->findShopOrderList($shopid, $starttime, $endtime);
        
        $this->returnSuccess($orderList);
        
    }
    
    public function queryDutyProductList(){
        
        $shopid = $this->getParam("shopid");
        $uniacid = $this->shopModel->findShopById($shopid)['uniacid'];
        $starttime = $this->orderService->queryLastDutyTime($shopid);
        $endtime = time();
        
        $orderList = $this->orderModel->findShopOrderList($shopid, $starttime, $endtime);
        
        $productlist = array();
        
        foreach($orderList as $key=>$value){
            
            $productinfo = [];

            try{

                if(isset($value["orderdetail"])) {
                    $productinfo = json_decode($value['orderdetail']);
                }

            }
            catch (\Exception $ex){

            }

            
            foreach($productinfo as $key=>$productinfovalue)
            {
                $productid = $productinfovalue->productid;

                if(isset($productlist[$productid]) == false){
                    $item = array();
                       
                    $item['productid'] = $productid;
                    $item['productname'] = $productinfovalue->productname;
                    $item["num"] = $productinfovalue->num;
                    $item['sum'] = $productinfovalue->num*$productinfovalue->price;
                    $item['price'] = $productinfovalue->price;

                }
                else{
                    $item = $productlist[$productid];
                    
                    $item['productid'] = $productid;
                    $item["num"] += $productinfovalue->num;
                    $item['sum'] += $productinfovalue->num*$productinfovalue->price;
                    $item['price'] = $productinfovalue->price;

                }

                $productlist[$productid] = $item;
            
            }
            
        }
        
        //$typeMap = $this->productTypeModel->getProductTypeMap($uniacid);
        
        $list = array();
        foreach($productlist as $key=>$value){
            $value['producttype'] = "-";
            $list[] = $value;
        }
        
        $this->returnSuccess($list);
    }
    
    public function callService(){
        
        $shopid = $this->getParam("shopid");
        $uid = $this->getParam("uid");
        $address = $this->getParam("address");
        
        $msg = $address + "需要网管服务";
        
        $this->redisService->pushNotify($shopid, $msg);
        
        $this->returnSuccess();
    }
    
    public function leaveMsg(){
        
        
        
    }
    
    public function queryPrintMsg(){
        
        $shopid = $this->getParam("shopid");
        
        $print = $this->redisService->popPrintMsg($shopid);

        $notify = $this->redisService->popNotify($shopid);

        $result = array();

        $result["print"] = $print;
        $result["notify"] = $notify;

        $this->returnSuccess($result);

    }


    public function createNetCardOrder(){
        
        $shopid = $this->getParam("shopid");
        $membercardid = $this->getParam("membercardid");
        $memberid = $this->getParam("memberid");
        $source = $this->getParam("source");
        $address = $this->getParam("address");
        $uniacid = $this->getUniacid();
        $userid = $this->getParamDefault("userid", 0);

        $membercard = $this->cardModel->getMemberCard($membercardid);

        if($membercard["ctype"] == 2){
            $result = $this->orderService->useNetCard($membercardid, $shopid, $uniacid, $userid, $memberid, $source, $address);
        }
        else if($membercard['ctype'] == 3){
            $result = $this->orderService->useProductCard($membercardid, $shopid, $uniacid,$memberid, $source, $address);
        }

        $this->redisService->pushNotify($shopid, "有新的兑换订单,请查看订单");
        
        if ($result == true) {
            $this->returnSuccess($result);
        }
        else{
            $this->returnFail("网费兑换失败,请重新兑换或找工作人员");
        }
    }
    
}
