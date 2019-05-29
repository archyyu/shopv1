<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

use model\ShopMemberGroup;

/**
 * Description of MemberController
 *
 * @author YJP
 */
class MemberController extends \controller\Controller{
    
    private $memberModel;

    private $memberGroupModel;
    
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
        $this->memberGroupModel = new ShopMemberGroup();
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }
    
    public function memberlist(){
        $this->smarty->display("admin/member/memberList.tpl");
    }

    public function loadMemberGroups(){

        $uniacid = $this->getUniacid();
        $list = $this->memberGroupModel->getMemberGroups($uniacid);
        $this->returnSuccess($list);

    }

    public function saveMemberGroup(){

        $uniacid = $this->getUniacid();
        $groupid = $this->getParam("groupid");
        $title = $this->getParam("title");
        $credit = $this->getParam("credit");

        $data = array();

        if($groupid != "") {
            $data['groupid'] = $groupid;
        }

        $data['uniacid'] = $uniacid;
        $data["title"] = $title;
        $data['credit'] = $credit;

        $result = $this->memberGroupModel->saveMemberGroup($data);

        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("保存失败");
        }

    }
    
    public function loadMembers(){
        $uniacid = $this->getUniacid();
        // $shopid = $this->getParam("shopid");
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $where = array();
        $where['uniacid'] = $uniacid;
        // $where["shopid"] = $shopid;
        
        $list = $this->memberModel->page($offset, $limit, "*", $where, "createtime");
        
        $this->returnSuccess($list);
        
    }



    
    
}
