<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

/**
 * Description of DutyController
 *
 * @author YJP
 */
class DutyController extends \controller\Controller{
    
    private $dutyModel;
    
    private $userModel;
    
    public function __construct() {
        parent::__construct();
        $this->dutyModel = new \model\ShopDuty();
        $this->userModel = new \model\ShopUser();
    }
    
    public function index(){
        $this->smarty->display("admin/duty.tpl");
    }
    
    public function loadDutys(){
        $uniacid = $this->getUniacid();
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $where = array();
        $where['uniacid'] = $uniacid;
        
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
