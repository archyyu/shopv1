<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

use model\ShopMember;
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
    
    private $userModel;
    
    private $redisService;
    
    private $cardModel;

    private $memberModel;
    
    
    public function __construct(){
        parent::__construct();
        $this->shopOrder = new ShopOrder();
        $this->shopOrderProduct = new ShopOrderproduct();
        $this->productService = new ProductService();
        $this->shopDuty = new \model\ShopDuty();
        $this->wechatAccount = new \model\WechatAccount();
        $this->shopModel = new \model\Shop();
        $this->userModel = new \model\ShopUser();
        $this->redisService = new RedisService();
        $this->cardModel = new \model\ShopMemberCard();
        $this->memberModel = new ShopMember();
    }
    
    //memberid => uid
    public function getOrderListByMemberid($memberid){
        
        $where = array();
        $where['memberid'] = $memberid;
        
        return $this->shopOrder->findOrders($where);
    }
    
    
    public function generateChargeOrder($memberid,$uniacid,$chargefee){

    	$order = array();
    	$order['id'] = $this->generateOrderId();
    	$order['shopid'] = 0;
    	$order['uniacid'] = $uniacid;
    	$order['createtime'] = time();
    	$order['ordersource'] = OrderType::FromPhone;
    	$order['ordertype'] = OrderType::ChargeOrder;
    	$order['orderstate'] = OrderType::UnPay;
    	$order['memberid'] = $memberid;
    	$order['paytype'] = OrderType::WechatPay;
    	$order['orderprice'] = $chargefee*100;

    	$result = $this->shopOrder->addOrder($order);

    	if($result == false){
    		return false;
		}
    	return $order['id'];
	}


    
    public function generateProductOrder($uniacid,$memberid,$userid,$shopid,$address,$productlist,
            $ordersource,$remark,$paytype,$membercardid = 0){
        
        $membercard = null;
        
        if($membercardid != 0){
            
            $membercard = $this->cardModel->getMemberCard($membercardid);
            
        }
        
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
        
        $userget = 0;
        
        $price = 0;
        foreach($productlist as $key=>$value){
            
            $discount = 100;
            
            if($membercard){

                if(isset($membercard["typeid"])){

                    if($value["typeid"] == $membercard["typeid"]){
                        $discount = $membercard['discount'];
                    }

                }
                
                if(isset($membercard["productid"])){
                    if($value["productid"] == $membercard["productid"]){
                        $discount = $membercard['discount'];
                    }
                }

            }
            $userget += $value['userget']*$value['num'];
            $price += ($value['price']*$value['num']*100)*($discount/100);
        }
        
        if($membercard){
            $price -= $membercard['exchange'];
        }
        
        $order['userget'] = $userget;
        $order['orderprice'] = $price;
        
        $orderResult = $this->shopOrder->addOrder($order);
        if($orderResult == false){
            logError("create order error");
            return false;
        }
        
        if($membercard){
            $this->cardModel->useMemberCard($membercardid);
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
        
        $order = $this->shopOrder->findOrderById($orderid);
        $this->printOrder($order);
        
    }

    public function payChargeOrder($orderid){

    	$orderData = array();
    	$orderData['id'] = $orderid;
    	$orderData['orderstate'] = OrderType::Payed;
    	$orderData['paytime'] = time();

    	$this->shopOrder->saveOrder($orderData,$orderid);

    	$order = $this->shopOrder->findOrderById($orderid);

		$member = $this->memberModel->queryMemberByUid($order['memberid']);

		$record = array();
		$record['credit2'] = $member['credit2'] + $order['orderprice']/100;





		$this->memberModel->saveMember($record,$order['memberid']);


	}
    
    public function printOrder($order){
        
        $order["shopname"] = $this->shopModel->findShopById($order['shopid'])["shopname"];
        $order["username"] = $this->userModel->getShopUserById($order['userid'])['username'];
        
        
        $this->redisService->pushPrintMsg($order);
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
