<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\mobile;

use service\SmsService;

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
    
    public function __construct() {
        parent::__construct();
        $this->cardService = new \service\CardService();
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
    }
    
    public function index(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('usermain.tpl');
        
    }
    
    public function getMemberInfo(){
        global $_W;
        
        $member = $this->shopMemberModel->queryMemberByUid($_W["member"]["uid"]);
        $this->returnSuccess($member);
    }
    
    public function loadProductTypeList(){
        global $_W;
        $uniacid = 1;//$_w["uniacid"];
        
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        
        $typeid = $this->getParam("type");
        $shopid = 1;
        
        $list = $this->productService->getProductList($shopid, $typeid);
        
        $this->returnSuccess($list);
    }
    
    public function createOrder(){
        
        global $_W;
        $productlist = json_decode(html_entity_decode($this->getParam("productlist")),true);
        $shopid = 1;
        
        $uniacid = $_W['uniacid'];
        $memberid = $_W["member"]["uid"];
        $openid = $_W["openid"];
        $address = "A001";
        $ordersource = 1;
        $remark = "";
        $paytype = 1;
        
        
        $orderid = $this->orderService->generateProductOrder($uniacid,$memberid, 0, $shopid, 
                $address, $productlist, $ordersource, $remark,$paytype);
        $order = $this->orderModel->findOrderById($orderid);
        $payinfo = $this->payService->getJsapiPay($order, $openid);
        $this->returnSuccess($payinfo);
    }
    
    public function tag(){
        global $_W;
        $uid = $_W['member']['uid'];
        
        $tag = $this->getParam("tag");
        
        $this->redisService->setMemberid($tag, $uid);
        exit("登陆成功");
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
        
        //$where['LIMIT'] = [$offset*$limit,$limit];
        //$where['ORDER'] = ["createtime" => 'DESC'];
        
        $list = $this->orderModel->findOrders($where);
        logInfo("getOrderList end");
        $this->returnSuccess($list);
        
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

    public function updateMemberInfo(){
        
        $phone = $this->getParam("phone");
        $code = $this->getParam("code");
        $idcard = $this->getParam("idcard");
        
        $memberid = $this->getUid();
        
        $data = array();
        $data["mobile"] = $phone;
        $data["idcard"] = $idcard;
        
        $this->shopMemberModel->saveMember($data, $memberid);
        $this->returnSuccess();
        
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
