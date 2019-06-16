<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

use model\ShopChargeCompaign;
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

    private $cardService;

    private $chargeCompaignModel;

    private $ShopOrder;
    
    
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
        $this->cardService = new CardService();
        $this->cardModel = new \model\ShopMemberCard();
        $this->memberModel = new ShopMember();
        $this->chargeCompaignModel = new ShopChargeCompaign();
        $this->orderModel = new \model\ShopOrder();
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
       return date('Ymdhis').substr(microtime(), 2, 6).rand(1000,9999);
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

        logInfo("print order:".$orderid);
        
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


		$list = $this->chargeCompaignModel->selectByUniacid($order['uniacid']);

		try{

			usort($list,function ($x,$y){
				return bccomp($x['chargefee'],$y['chargefee']);
			});

			$chargefee = $order['orderprice']/100;
			$awardfee = 0;
			$cardtypeid = 0;
			$num = 0;
			foreach($list as $key=>$value){

				if($chargefee >= $value['chargefee']){
					$awardfee = $value['awardfee'];
					$cardtypeid = $value["cardid"];
					$num = $value["cardnum"];
					break;
				}

			}


			$record['credit2'] += $awardfee;

			$card = $this->cardService->getCardType($cardtypeid);
			if(isset($card)){
				$this->cardService->sendMemberCard(0,$cardtypeid,$member["uid"],$num);

				$content = "您收到卡券【".$card['cardname']."】 * " . $num . "张";

				$wechat = $this->wechatAccount->findWechatAccountByUniacid($member["uniacid"]);

				(new WechatService)->sendNotice($member['openid'], $content, $wechat["acid"]);

			}




		}
		catch(\Exception $ex){
			logError("charge err",$ex);
		}



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
    
    public function payByAccount($memberid, $uniacid, $shopid, $address, $productlist, $ordersource, $remark, $membercardid, $password){
        
        $paytype = OrderType::AccountPay;
        $data = array();
        $data['result'] = false;
        $data['info'] = "";

        $member = $this->memberModel->queryMemberByUid($memberid);
        if (empty($member)) {
            $data['info'] = "会员不存在";
            return $data;
        }

        if(md5($password) != $member['pay_password']){
            logInfo("pass:$password  paypassword:".$member['pay_password']);
            $data['info'] = "密码错误";
            return $data;
        }


        $orderid = $this->generateProductOrder($uniacid,$memberid,0,$shopid,$address,$productlist,$ordersource,$remark,$paytype,$membercardid);

        $order = $this->orderModel->findOrderById($orderid);

        if($order['orderprice']/100 > $member['credit2']){
            $data['info'] = "余额不足";
            return $data;
        }

        $this->payOrder($shopid,$orderid);

        $member['credit2'] = $member['credit2'] - $order['orderprice']/100;

        $result = $this->memberModel->saveMember($member,$memberid);

        if(!$result){
            $data['info'] = "余额支付失败";
            return $data;
        }

        $data['result'] = true;
        $data['info'] = "支付成功";
        return $data;
    }
	
    
}
