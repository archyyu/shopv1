<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

/**
 * Description of MemberController
 *
 * @author YJP
 */
class MemberController extends \controller\Controller{
    
    private $memberModel;
    
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }
    
    public function memberlist(){
        $this->smarty->display("admin/member/memberList.tpl");
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
