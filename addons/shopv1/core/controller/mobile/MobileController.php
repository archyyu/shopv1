<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\mobile;

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
    
    public function __construct() {
        parent::__construct();
        $this->cardService = new \service\CardService();
        $this->shopCardTypeModel = new \model\ShopCardtype();
        $this->shopMemberCardModel = new \model\ShopMemberCard();
        $this->shopFansModel = new \model\ShopFans();
        $this->shopMemberModel = new \model\ShopMember();
        $this->shopCardActivity = new \model\ShopCardActivity();
    }
    
    public function index(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('usermain.tpl');
        
    }
    
    public function getMemberInfo(){
        global $_W;
        return $this->returnSuccess($_W);
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
    
    
    public function getOpenId(){
        global $_W;
        return $_W["openid"];
    }
    
    public function getUid(){
        global $_W;
        return $_W["member"]["uid"];
    }
    
    
}
