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
    
    public function generateProductOrder($memberid,$userid,$shopid,$address,$productlist,$ordersource,$remark){
        
        $order = array();
        $order['id'] = $this->generateOrderId();
        $order['createtime'] = time();
        $order['ordersource'] = $ordersource;
        $order['ordertype'] = OrderType::ProductOrder;
        $order['orderstate'] = OrderType::UnPay;
        $order['address'] = $address;
        $order['remark'] = $remark;
        
        
    }
    
    public function generateOrderId(){
        return date('YmdHis').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
    }
    
    public function payOrder(){
        
    }
    
    public function cancelOrder(){
        
    }
    
}
