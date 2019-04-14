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
    
    public function __controller(){
        parent::__controller();
        $this->shopOrder = new ShopOrder();
        $this->shopOrderProduct = new ShopOrderproduct();
        $this->productService = new ProductService();
    }
    
    public function generateProductOrder($memberid,$userid,$shopid,$address,$productlist,$ordersource,$remark){
        
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
        
        
    }
    
    public function generateOrderId(){
        return date('YmdHis').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
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
    
}
