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
    
    public function __controller(){
        parent::__controller();
        $this->shopOrder = new ShopOrder();
        $this->shopOrderProduct = new ShopOrderproduct();
        $this->productService = new ProductService();
        $this->shopDuty = new \model\ShopDuty();
    }
    
    public function generateProductOrder($memberid,$userid,$shopid,$address,$productlist,$ordersource,$remark,$paytype,$from){
        
        $order = array();
        $order['id'] = $this->generateOrderId();
        $order['shopid'] = $shopid;
        $order['userid'] = $userid;
        $order['createtime'] = time();
        $order['ordersource'] = $ordersource;
        $order['ordertype'] = OrderType::ProductOrder;
        $order['orderstate'] = OrderType::UnPay;
        $order['address'] = $address;
        $order['remark'] = $remark;
        $order['memberid'] = $memberid;
        $order['paytype'] = $paytype;
        $order['ordersource'] = $from;
        
        $price = 0;
        foreach($productlist as $key=>$value){
            $price += $value['price']*$value['num'];
        }
        
        $order['orderprice'] = $price;
        
        $orderResult = $this->shopOrder->saveOrder($order);
        if($orderResult == false){
            logError("create order error");
            return false;
        }
        
        foreach ($productlist as $key=>$value){
            
            $orderProduct = array();
            $orderProduct["orderid"] = $order['id'];
            $orderProduct["productid"] = $value["productid"];
            $orderProduct['num'] = $value['num'];
            $orderProduct['orderstate'] = $value['orderstate'];
            
            $this->shopOrderProduct->addOrderProduct($orderProduct);
            
        }
        
        return $order['id'];
    }
    
    public function generateOrderId(){
       return date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);
    }
    
    public function payOrder($shopid,$orderid){
        
        $orderData = array();
        $orderData["id"] = $orderid;
        $orderData["orderstate"] = OrderType::Payed;
        
        $this->shopOrder->saveOrder($orderData);
        
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
        $starttime = 0;
        
        $lastDuty = $this->dutyModel->selectShopLastDuty($shopid);
        if(isset($lastDuty)){
            $starttime = $lastDuty["submittime"];
        }
        
        return $starttime;
    }
    
    public function generateDuty($shopid){
        $starttime = 0;
        
        $lastDuty = $this->dutyModel->selectShopLastDuty($shopid);
        if(isset($lastDuty)){
            $starttime = $lastDuty["submittime"];
        }
        
        $endtime = time();
        
        $orderList = $this->orderModel->findShopOrderList($shopid, $starttime, $endtime);
        
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
        $duty['productcash'] = $productcash;
        $duty['productwechat'] = $productwechat;
        $duty['productalipay'] = $productalipay;
        
        return $duty;
    }
    
}
