<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

/**
 * Description of MemberController
 *
 * @author YJP
 */
class MemberController extends \controller\Controller{
    
    private $memberModel;
    
    private $memberCardModel;
    
    private $redisService;
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
        $this->memberCardModel = new \model\ShopMemberCard();
        $this->redisService = new \service\RedisService();
    }
    
    public function queryMemberList(){
        
        $uniacid = $this->getUniacid();
        
        $where = array();
        $where["uniacid"] = 2;
        
        $list = $this->memberModel->queryMemberList($where);
        $this->returnSuccess($list);
    }
    
    public function getMemberCardList(){
        
        $memberid = $this->getParam("memberid");
        $list = $this->memberCardModel->getMemberList($memberid);
        $this->returnSuccess($list);
        
    }
    
    public function queryMemberInfoBytag(){
        
        $shopid = $this->getParam("shopid");
        $address = $this->getParam("address");
        $tag = $this->getParam("tag");
        
        $memberid = $this->redisService->getMemberIdByTag($tag);
        
        if(isset($memberid)){
            
            $obj = $this->memberModel->queryMemberByUid($memberid);
            
            $this->returnSuccess($obj);
            
        }
        else{
            $this->returnFail("no");
        }
        
    }
    
    public function callService(){
        
        $shopid = $this->getParam("shopid");
        $address = $this->getParam("address");
        
        $msg = $address."呼叫网管";
        //TODO
    }
    
    public function leaveMsg(){
        //TODO
    }
    
    public function updateMemberInfo(){
        
        $uid = $this->getParam("uid");
        $phone = $this->getParam("phone");
        $idcard = $this->getParam("idcard");
        
        $data = array();
        $data["mobile"] = $phone;
        $data["idcard"] = $idcard;
        
        $result = $this->memberModel->saveMember($data,$uid);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("修改失败");
        }
    }
    
}
