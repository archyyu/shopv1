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
        
        $uniacid = $this->getUniacid();
        
        if(isset($uniacid) == false){
            $shopid = $this->getParam('shopid');
            $uniacid = $this->productService->getUniacidByShopId($shopid);
        }
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        
        $typeid = $this->getParam("type");
        $shopid = 1;
        
        $list = $this->productService->getProductList($shopid, $typeid);
        
        $this->returnSuccess($list);
    }
    
    public function tag(){
        global $_W;
        $uid = $_W['uid'];
        
        $tag = $this->getParam("tag");
        
        $this->redisService->setMemberid($tag, $uid);
        
        exit("登陆成功");
    }
    
    
    
    public function getCard(){
        
        $id = $this->getParam("activityid");
        $userid = $this->getParam("userid");
        $uid = $this->getUid();
        
        $activity = $this->shopCardActivity->findActivity($id);
        if(isset($activity) == false){
            $this->returnFail("活动不存在");
        }
        
        if($activity["num"] >= $activity["sum"]){
            $this->returnFail("活动结束");
        }
        
        $this->cardService->memberGetCardFromActivity($activity, $uid, $userid);
        $this->returnSuccess("领取成功");
    }
    
    public function getOrderList(){
        
        $uid = $this->getUid();
        
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        logInfo("getOrderList uid:$uid offset:$offset limit:$limit");
        
        $where = array();
        $where["memberid"] = $uid;
        
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
