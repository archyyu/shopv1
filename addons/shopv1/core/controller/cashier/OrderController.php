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
    
    private $orderModel;
    
    public function __construct() {
        parent::__construct();
        $this->orderService = new \service\OrderService();
        $this->orderModel = new \model\ShopOrder();
    }
    
    public function addOrder(){
        
        $memberid = $this->getParamDefault("memberid",0);
        $userid = $this->getParamDefault("userid", 0);
        $shopid = $this->getParam("shopid");
        $address = $this->getParamDefault("address", "A001");
        $ordersource = $this->getParam("from");
        $remark = $this->getParamDefault('remark','');
        $paytype = $this->getParam("paytype");
        
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        $orderid = $this->orderService->generateProductOrder($memberid, $userid, $shopid, $address, $productlist, $ordersource, $remark,$paytype);
        
        if($ordersource == 0){
            $this->orderService->payOrder($shopid, $orderid);
        }
        
        $this->returnSuccess();
        
    }
    
    public function payOrder(){
        
    }
    
    public function cashierQueryOrder(){
        
        $shopid = $this->getParam("shopid");
        $starttime = $this->orderService->queryLastDutyTime($shopid);
        $endtime = time();
        
        $orderList = $this->orderModel->findShopOrderList($shopid, $starttime, $endtime);
        
        $this->returnSuccess($orderList);
        
    }
    
}
