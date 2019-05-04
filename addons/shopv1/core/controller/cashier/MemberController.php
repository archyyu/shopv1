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
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
    }
    
    public function queryMemberList(){
        
        $uniacid = $this->getUniacid();
        
        $where = array();
        $where["uniacid"] = 2;
        
        $list = $this->memberModel->queryMemberList($where);
        $this->returnSuccess($list);
    }
    
}
