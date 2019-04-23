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
    
    private $productTypeModel;
    
    public function __construct() {
        parent::__construct();
        $this->productTypeModel = new \model\ShopProductType();
        $this->orderService = new \service\OrderService();
        $this->orderModel = new \model\ShopOrder(); 
    }
    
    public function createOrder(){
        
        $memberid = $this->getParamDefault("memberid",0);
        $userid = $this->getParamDefault("userid", 0);
        $shopid = $this->getParam("shopid");
        $address = $this->getParamDefault("address", "A001");
        $ordersource = $this->getParam("from");
        $remark = $this->getParamDefault('remark','');
        $paytype = $this->getParam("paytype");
        
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        $orderid = $this->orderService->generateProductOrder($memberid, $userid, $shopid, $address, $productlist, $ordersource, $remark,$paytype);
        
        if($orderid == false){
            $this->returnFail("订单错误");
        }
        
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
    
    public function queryDutyProductList(){
        
        $shopid = $this->getParam("shopid");
        $uniacid = $this->shopModel->findShopById($shopid)['uniacid'];
        $starttime = $this->orderService->queryLastDutyTime($shopid);
        $endtime = time();
        
        $orderList = $this->orderModel->findShopOrderList($shopid, $starttime, $endtime);
        
        $productlist = array();
        
        foreach($orderList as $key=>$value){
            
            $productinfo = json_decode($value['orderdetail'], true);
            $productid = $productinfo['productid'];
            
            if(isset($productlist[$productid])){
                
                $item = array();
                
                $productlist[$productid]["productid"] = $productid;
                $productlist[$productid]["num"] = $productinfo['num'];
                $productlist[$productid]['sum'] = $productinfo['num']*$productinfo['price'];
                $productlist[$productid]['price'] = $productinfo['price'];
                
            }
            else{
                
                $productlist[$productid]["num"] += $productinfo['num'];
                $productlist[$productid]['sum'] += $productinfo['num']*$productinfo['price'];
                $productlist[$productid]['price'] = $productinfo['price'];
            }
            
            $productlist[$productid] = $item;
            
        }
        
        $typeMap = $this->productTypeModel->getProductTypeMap($uniacid);
        
        $list = array();
        foreach($productlist as $key=>$value){
            $value['producttype'] = "-";
            $list[] = $value;
        }
        
        $this->returnSuccess($list);
    }
    
}
