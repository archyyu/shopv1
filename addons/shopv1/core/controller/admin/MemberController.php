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
    
    private $dutyModel;
    
    private $userModel;
    
    public function __construct() {
        parent::__construct();
        $this->dutyModel = new \model\ShopDuty();
        $this->userModel = new \model\ShopUser();
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }
    
    public function memberlist(){
        $this->smarty->display("admin/member/memberList.tpl");
    }
    
    
    public function loadDutys(){
        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $where = array();
        $where['uniacid'] = $uniacid;
        $where["shopid"] = $shopid;
        
        $userMap = $this->userModel->getUserMap($uniacid);
        $shopMap = $this->shopModel->findShopMapByUnacid($uniacid);
        
        $data = $this->dutyModel->page($offset,$limit,"*",$where,"id");
        
        foreach($data['rows'] as $key=>$value){
            $data['rows'][$key]['shopname'] = $shopMap[$value['shopid']]['shopname'];
            $data['rows'][$key]['username'] = $userMap[$value['userid']]['account'];
        }
        
        $this->returnSuccess($data);
        
    }
    
    
    
}
