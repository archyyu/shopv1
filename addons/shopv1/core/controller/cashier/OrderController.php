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
    
    public function __construct() {
        parent::__construct();
        $this->orderService = new \service\OrderService();
    }
    
    public function addOrder(){
        
        $memberid = $this->getParamDefault("memberid",0);
        $userid = $this->getParamDefault("userid", 0);
        $shopid = $this->getParam("shopid");
        $address = $this->getParamDefault("address", "A001");
        $ordersource = 2;
        $remark = "";
        
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        
        $this->orderService->generateProductOrder($memberid, $userid, $shopid, $address, $productlist, $ordersource, $remark);
        
    }
    
    public function payOrder(){
        
    }
    
    public function queryOrder(){
        
    }
    
}
