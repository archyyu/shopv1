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
        $uniacid = $this->getUniacid();
        
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        $orderid = $this->orderService->generateProductOrder($uniacid,$memberid, $userid, $shopid, $address, $productlist, $ordersource, $remark,$paytype);
        
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
    
}
