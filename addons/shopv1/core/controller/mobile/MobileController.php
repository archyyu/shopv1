<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\mobile;

use model\Shop;
use model\ShopChargeCompaign;
use service\SmsService;
use service\WechatService;

/**
 * Description of CardController
 *
 * @author YJP
 */
class MobileController extends \controller\Controller{
    
    private $shopCardTypeModel;
    
    private $shopMemberCardModel;
    
    private $shopMemberModel;
    
    private $shopFansModel;
    
    private $shopCardActivity;
    
    private $cardService;
    
    private $redisService;

    private $smsService;
    
    private $orderModel;
    
    private $productTypeModel;
    
    private $productService;
    
    private $orderService;
    
    private $payService;

    private $shopNoviceAwardModel;

    private $chargeCompaignModel;
    
    public function __construct() {
        parent::__construct();
        $this->cardService = new \service\CardService();
        //$this->shopModel = new \model\Shop();
        $this->shopCardTypeModel = new \model\ShopCardtype();
        $this->shopMemberCardModel = new \model\ShopMemberCard();
        $this->shopFansModel = new \model\ShopFans();
        $this->shopMemberModel = new \model\ShopMember();
        $this->shopCardActivity = new \model\ShopCardActivity();
        $this->redisService = new \service\RedisService();
        $this->smsService = new \service\SmsService();
        $this->orderModel = new \model\ShopOrder();
        $this->productTypeModel = new \model\ShopProductType();
        $this->productService = new \service\ProductService();
        $this->orderService = new \service\OrderService();
        $this->payService = new \service\PayService();
        $this->shopNoviceAwardModel = new \model\ShopNoviceAward();
        $this->chargeCompaignModel = new ShopChargeCompaign();
    }
    
    public function index(){
        
        global $_W;
        
        $member = $this->shopMemberModel->queryMemberByUid($_W["member"]["uid"]);
        if ($member && $member['isnew'] == 0) {
            //发送新手奖励
            $award = $this->shopNoviceAwardModel->findAwardByUniacid($member['uniacid']);
            if ($award) {

                $b = false;
                $content = "您收到先手奖励:";

                //发卡券
                if ($award['cardtypeid'] > 0) {
                    $this->cardService->sendMemberCard(0,$award['cardtypeid'],$member['uid'],1);
                    $data['isnew'] = 1;
                    $b = true;
                    $content .= "卡券一张,";
                }

                //发积分
                if ($award['points'] > 0) {
                    
                    $data['credit1'] = $member['credit1'] + $award['points'];
                    $data['isnew'] = 1;
                    $b = true;
                    $content .= "积分" . $award['points'] . "个";
                }

                if ($b == true && !empty($data)) {
                    $this->shopMemberModel->saveMember($data, $member['uid']);

                    $fan = $this->shopFansModel->findFanByUid($member['uid'], $member['uniacid']);
                    if ($fan) {
                        
                        (new WechatService)->sendNotice($fan['openid'], $content, $_W['acid']);
                    }
                }
            }
        }


        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('usermain.tpl');
        
    }
    
    public function getMemberInfo(){
        global $_W;
        
        logInfo("member uid:".$_W["member"]["uid"]);
        
        $member = $this->shopMemberModel->queryMemberByUid($_W["member"]["uid"]);
        $list = $this->shopMemberCardModel->getMemberList($_W["member"]["uid"], 0);
        
        $member["cardsize"] = count($list);
        
        $this->returnSuccess($member);
    }

    public function loadShopList(){
        global $_W;
        $uniacid = $_W['uniacid'];

        $list = $this->shopModel->findShopListByUniacid($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProductTypeList(){
        global $_W;
        $uniacid = $_W["uniacid"];
        
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        
        $typeid = $this->getParam("type");
        $shopid = $this->getParam("shopid");
        
        $list = $this->productService->getProductList($shopid, $typeid);
        
        $this->returnSuccess($list);
    }
    
    public function createOrder(){

		global $_W;
		$productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);

		$shopid = $this->getParam("shopid");
		$uniacid = $_W['uniacid'];
		$memberid = $_W["member"]["uid"];
		$openid = $_W["openid"];
		$address = $this->getParam("address");
		$ordersource = 1;
		$remark = $this->getParam("remark");
		$membercardid = $this->getParamDefault("membercardid",0);

		$paytype = $this->getParam("paytype",2);
		$password = $this->getParam("password");



		if($paytype == 5){

            $data = $this->orderService->payByAccount($memberid, $uniacid, $shopid, $address, 
                $productlist, $ordersource, $remark, $membercardid, $password);

            if ($data['result'] == false) {
                $this->returnFail($data['info']);
            }
            else{
                $this->returnSuccess();
            }
            return ;

			// $member = $this->shopMemberModel->queryMemberByUid($memberid);

			// $orderid = $this->orderService->generateProductOrder($uniacid,$memberid,0,$shopid,$address,$productlist,$ordersource,$remark,$paytype,$membercardid);

			// $order = $this->orderModel->findOrderById($orderid);

			// if(md5($password) != $member['pay_password']){
			// 	logInfo("pass:$password  paypassword:".$member['pay_password']);
			// 	$this->returnFail("密码错误");
			// 	return ;
			// }

			// if($order['orderprice']/100 > $member['credit2']){
			// 	$this->returnFail("余额不足");
			// 	return;
			// }

			// $this->orderService->payOrder($shopid,$orderid);

			// $member['credit2'] = $member['credit2'] - $order['orderprice']/100;

			// $result = $this->shopMemberModel->saveMember($member,$memberid);

			// if($result){
			// 	$this->returnSuccess();
			// }
			// else{
			// 	$this->returnFail("err");
			// }

		}
		else{
			$orderid = $this->orderService->generateProductOrder($uniacid,$memberid,0,$shopid,$address,$productlist,$ordersource,$remark,$paytype,$membercardid);
			$order = $this->orderModel->findOrderById($orderid);
			$payinfo = $this->payService->getJsapiPay($order,$openid);
			$this->returnSuccess($payinfo);
		}



	}
    
    public function tag(){
        
        $uid = $this->getUid();
        $openid = $this->getOpenId();
        
        $tag = $this->getParam("tag");
        
        $this->redisService->setMemberid($tag, $uid);
        
        exit("登陆成功 uid:$uid  openid:$openid tag:$tag");
    }
    
    public function getCardList(){
        
        $uid = $this->getUid();
        
        $list = $this->shopMemberCardModel->getMemberList($uid, 0);
        $this->returnSuccess($list);
    }
    
    public function getOrderList(){
        
        $uid = $this->getUid();
        
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        logInfo("getOrderList uid:$uid offset:$offset limit:$limit");
        
        $where = array();
        $where["memberid"] = $uid;
        $where["orderstate[>=]"] = 0;
        
        $where['LIMIT'] = [$offset*$limit,$limit];
        $where['ORDER'] = ["createtime" => 'DESC'];
        
        $list = $this->orderModel->findOrders($where);
        logInfo("getOrderList end");
        $this->returnSuccess($list);
        
    }


    public function getChargeCompaignList(){

		global $_W;
		$uniacid = $_W['uniacid'];

		$list = $this->chargeCompaignModel->selectByUniacid($uniacid);
		$this->returnSuccess($list);

	}


	public function charge(){
		global $_W;
		$openid = $_W['openid'];
		$uniacid = $_W['uniacid'];
		$memberid = $_W['member']['uid'];
		$chargefee = $this->getParam("chargefee");


		$orderid = $this->orderService->generateChargeOrder($memberid,$uniacid,$chargefee);
		$order = $this->orderModel->findOrderById($orderid);
		$payinfo = $this->payService->getJsapiPay($order, $openid);
		$this->returnSuccess($payinfo);

	}

    public function sendVerifyCode(){

        $phone = $this->getParam("phone");
        $code = rand(100000,999999);
        
        $content = "验证码为;".$code;
        $result = $this->smsService->sendContent($phone, $content);
        if($result == "0"){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("短信发送失败");
        }
    }
    
    public function getCode(){
        
        $phone = $this->getParam("phone");
        
        $code = rand(1000, 9999);
        
        $content = "短信验证码: $code";
        $this->smsService->sendContent($phone, $content);
        $this->redisService->setPhoneVerifyCode($phone, $code);
        $this->returnSuccess();
    }

    public function updateMemberInfo(){
        
        $phone = $this->getParam("phone");
        $code = $this->getParam("code");
        $idcard = $this->getParam("idcard");
        $pay_password = $this->getParam("pay_password");
        
        $memberid = $this->getUid();
        
        if($code != $this->redisService->getPhoneCode($phone)){
            
            $this->returnFail("验证码错误");
        }
        
        $data = array();
        $data["mobile"] = $phone;
        $data["idcard"] = $idcard;
        $data['pay_password'] = md5($pay_password);
        
        $this->shopMemberModel->saveMember($data, $memberid);
        
        $obj = $this->shopMemberModel->queryMemberByUid($memberid);
        
        $this->returnSuccess($obj);
        
    }
    
    
    public function getOpenId(){
        global $_W;
        return $_W["openid"];
    }
    
    public function getUid(){
        global $_W;
        return $_W["member"]["uid"];
    }
    
    
}
