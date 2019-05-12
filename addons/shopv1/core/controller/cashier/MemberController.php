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
    
    private $memberTagModel;
    
    private $memberMessage;
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
        $this->memberCardModel = new \model\ShopMemberCard();
        $this->redisService = new \service\RedisService();
        $this->memberTagModel = new \model\ShopMemberTag();
        $this->memberMessage = new \model\ShopMessage();
    }
    
    public function queryMemberList(){
        
        $uniacid = $this->getUniacid();
        
        $where = array();
        $where["uniacid"] = $uniacid;
        
        $list = $this->memberModel->queryMemberList($where);
        $this->returnSuccess($list);
    }
    
    //TODO
    public function queryMemberInfo(){
        
        $uid = $this->getParam("uid");
        
        $obj = $this->memberModel->queryMemberByUid($uid);
        $obj["taglist"] = $this->memberTagModel->getMemberTaglist($uid);
        
        $this->returnSuccess($obj);
        
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
        
        $this->redisService->pushNotify($shopid, $msg);
        
        $this->returnSuccess();
        
    }
    
    public function leaveMsg(){
        //columns id uniacid shopid uid createtime address content state
        
        $shopid = $this->getParam("shopid");
        $uid = $this->getParam("uid");
        $address = $this->getParam("address");
        $content = $this->getParam("content");
        
        $data = array();
        $data["shopid"] = $shopid;
        $data["uid"] = $uid;
        $data["createtime"] = time();
        $data["address"] = $address;
        $data["content"] = $content;
        
        $this->memberMessage->addMsg($data);
        
        $this->returnSuccess();
        
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
    
    public function addMemberTag(){
        
        $uid = $this->getParam("memberid");
        $tag = $this->getParam("tag");
        
        $member = $this->memberModel->queryMemberByUid($uid);
        
        $data = array();
        $data['memberid'] = $uid;
        $data['tag'] = $tag;
        $data['uniacid'] = $member['uniacid'];
        $data['tagtype'] = 0;
        
        $this->memberTagModel->addMemberTag($data);
        
        $this->returnSuccess();
        
    }
    
    public function removeMemberTag(){
        
        $tagid = $this->getParam("tag");
        
        $this->memberTagModel->removeMemberTag($tagid);
        
        $this->returnSuccess();
        
    }
    
}
