<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

/**
 * Description of OrderController
 *
 * @author YJP
 */
class OrderController extends \controller\Controller{
    
    private $orderModel;
    
    public function __construct() {
        parent::__construct();
        $this->orderModel = new \model\ShopOrder();
    }
    
    public function index(){
        $this->smarty->display('admin/waterbar/order.tpl');
    }
    
    public function loadOrders(){
        
        $uniacid = $this->getUniacid();
        
        $where['uniacid'] = $uniacid;
        $where["ORDER"] = ["createtime"=>"DESC"];
        
        $list = $this->orderModel->findOrders($where);
        
        $this->returnSuccess($list);
        
    }
    
}
