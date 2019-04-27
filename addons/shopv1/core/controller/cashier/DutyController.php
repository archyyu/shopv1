<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;


/**
 * Description of DutyController
 *
 * @author YJP
 */
class DutyController extends \controller\Controller{
    
    //put your code here
    
    private $dutyModel;
    private $orderModel;
    private $orderService;
    
    public function __construct() {
        parent::__construct();
        $this->dutyModel = new \model\ShopDuty();
        $this->orderModel = new \model\ShopOrder();
        $this->orderService = new \service\OrderService();
    }
    
    public function queryDuty(){
        $shopid = $this->getParam("shopid");
        
        $duty = $this->orderService->generateDuty($shopid);
        
        $this->returnSuccess($duty);
    }
    
    public function submitDuty(){
        
        $shopid = $this->getParam('shopid');
        $userid = $this->getParam('userid');
        $uniacid = $this->getUniacid();
        
        $duty = $this->orderService->generateDuty($shopid);
        $duty['userid'] = $userid;
        $duty['shopid'] = $shopid;
        $duty['uniacid'] = $uniacid;
        
        unset($duty['productsum']);
        
        if($this->dutyModel->saveDuty($duty)){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库错误");
        }
        
    }
    
}
