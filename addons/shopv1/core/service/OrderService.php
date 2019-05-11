<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

use model\ShopOrder;
use model\ShopOrderproduct;

use common\OrderType;

use unionpay\AppUtil;

/**
 * Description of OrderService
 *
 * @author Administrator
 */
class OrderService extends Service{
    
    private $shopOrder;
    
    private $shopOrderProduct;
    
    private $productService;
    
    private $shopDuty;
    
    private $wechatAccount;
    
    private $shopModel;
    
    public function __construct(){
        parent::__construct();
        $this->shopOrder = new ShopOrder();
        $this->shopOrderProduct = new ShopOrderproduct();
        $this->productService = new ProductService();
        $this->shopDuty = new \model\ShopDuty();
        $this->wechatAccount = new \model\WechatAccount();
        $this->shopModel = new \model\Shop();
    }
    
    //memberid => uid
    public function getOrderListByMemberid($memberid){
        
        $where = array();
        $where['memberid'] = $memberid;
        
        return $this->shopOrder->findOrders($where);
    }
    
    
    
    
    public function generateProductOrder($uniacid,$memberid,$userid,$shopid,$address,$productlist,$ordersource,$remark,$paytype){
        
        $order = array();
        $order['id'] = $this->generateOrderId();
        logInfo("orderid:".$order['id']);
        $order['shopid'] = $shopid;
        $order['uniacid'] = $uniacid;
        $order['userid'] = $userid;
        $order['createtime'] = time();
        $order['ordersource'] = $ordersource;
        $order['ordertype'] = OrderType::ProductOrder;
        $order['orderstate'] = OrderType::UnPay;
        $order['address'] = $address;
        $order['remark'] = $remark;
        $order['memberid'] = $memberid;
        $order['paytype'] = $paytype; 
        $order['orderdetail'] = json_encode($productlist);
        
        $price = 0;
        foreach($productlist as $key=>$value){
            $price += $value['price']*$value['num']*100;
        }
        
        $order['orderprice'] = $price;
        
        $orderResult = $this->shopOrder->addOrder($order);
        if($orderResult == false){
            logError("create order error");
            return false;
        }
        
        foreach ($productlist as $key=>$value){
            
            $orderProduct = array();
            $orderProduct["orderid"] = $order['id'];
            $orderProduct["productid"] = $value["productid"];
            $orderProduct['num'] = $value['num'];
            $orderProduct['orderstate'] = OrderType::UnPay;
            
            $this->shopOrderProduct->addOrderProduct($orderProduct);
            
        }
        
        return $order['id'];
    }
    
    public function generateOrderId(){
       return date('Ymdhis').rand(10000, 99999);
    }
    
    public function payOrder($shopid,$orderid){
        
        $orderData = array();
        $orderData["id"] = $orderid;
        $orderData["orderstate"] = OrderType::Payed;
        $orderData['paytime'] = time();
        
        $this->shopOrder->saveOrder($orderData,$orderid);
        
        $orderProductData = array(); 
        $orderProductData["orderstate"] = OrderType::Payed;
        
        $this->shopOrderProduct->updateOrderProductList($orderProductData, $orderid);
        
        $orderProductList = $this->shopOrderProduct->findOrderProductListByOrderId($orderid);
        foreach($orderProductList as $key=>$value){
            $this->productService->addProductSale($value['productid'], $value['num']);
            $this->productService->updateProdudctInventory($shopid, $value['productid'], $value['num'], OrderType::InventoryChangeOrderPay,"订单号".$orderid);
        }
        
    }
    
    
    
    public function cancelOrder(){
        
    }
    
    public function queryLastDutyTime($shopid){
        $starttime = 631152000;
        
        $lastDuty = $this->shopDuty->selectShopLastDuty($shopid);
        if(isset($lastDuty)){
            $starttime = $lastDuty["endtime"];
        }
        
        return $starttime;
    }
    
    public function generateDuty($shopid){
        $starttime = 0;
        
        $lastDuty = $this->shopDuty->selectShopLastDuty($shopid);
        if(isset($lastDuty)){
            $starttime = $lastDuty["endtime"];
        }
        
        $endtime = time();
        
        $orderList = $this->shopOrder->findShopOrderList($shopid, $starttime, $endtime);
        
        $productcash = 0;
        $productwechat = 0;
        $productalipay = 0;
        
        foreach($orderList as $key=>$value){
            if($value['paytype'] == 0){
                //cash
                $productcash += $value['orderprice'];
            }
            else if($value['paytype'] == 1){
                //wechat
                $productwechat += $value['orderprice'];
            }
            else if($value['paytype'] == 2){
                //ali
                $productalipay += $value['orderprice'];
            }
        }
        
        $duty['starttime'] = $starttime;
        $duty['endtime'] = time();
        $duty['productcash'] = $productcash/100;
        $duty['productwechat'] = $productwechat/100;
        $duty['productalipay'] = $productalipay/100;
        $duty['ordersize'] = count($orderList);
        $duty['productsum'] = ($productcash + $productwechat + $productalipay)/100;
        
        return $duty;
    }
    
    
	
    
}
