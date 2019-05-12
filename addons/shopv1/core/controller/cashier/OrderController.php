<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

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
    
    
    
    public function __construct() {
        parent::__construct();
        $this->productTypeModel = new \model\ShopProductType();
        $this->orderService = new \service\OrderService();
        $this->payService = new \service\PayService();
        $this->orderModel = new \model\ShopOrder(); 
        $this->wechatModel = new \model\WechatAccount();
        $this->redisService = new \service\RedisService();
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
        
        if(isset($uniacid) == false){
            $uniacid = $this->shopModel->findShopById($shopid)['uniacid'];
        }
        
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
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

        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("失败");
        }
    }
    
    public function payOrder(){
        
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
            
            $this->orderService->payOrder($order['shopid'], $orderid);
            
            exit("success");
        }
        else{
            exit("error");
        }
    }
    
    public function queryOrderState(){
        
        $orderid = $this->getParam("orderid");
        $order = $this->orderModel->findOrderById($orderid);
        $this->returnSuccess($order['orderstate']);
        
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
            
            $productinfo = json_decode($value['orderdetail']);
            
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
    
}
