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
    
    private $storeModel;
    
    private $productModel;
    
    public function __construct() {
        parent::__construct();
        $this->storeModel = new \model\ShopStore();
        $this->orderModel = new \model\ShopOrder();
        $this->productModel = new \model\ShopProduct();

    }
    
    public function index(){
        $this->smarty->display('admin/waterbar/order.tpl');
    }
    
    public function loadOrders(){
        
        $uniacid = $this->getUniacid();
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $timearea = $this->getParam("timearea");
        $orderstate = $this->getParam("orderstate");
        $userid = $this->getParam("userid");
        

        $where['uniacid'] = $uniacid;
        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $where['createtime[>=]'] = strtotime($timeArr[0] . " 00:00:00");
            $where['createtime[<=]'] = strtotime($starttime[1] . " 23:59:59");
        }

        if ((int)$orderstate != 2) {
            $where['orderstate'] = $orderstate;
        }

        if ($userid) {
            $where['userid'] = $userid;
        }
        
        
        
//        $where["ORDER"] = ["createtime"=>"DESC"];
        
//        $storeMap = $this->storeModel->getStoreMapByUnacid($uniacid);
//        $productMap = $this->productModel->findProductMapByUniacid($uniacid);
        
        $list = $this->orderModel->page($offset, $limit, "*", $where, "createtime");
        
        // foreach($list["rows"] as $key=>$value){
            
            
            
        //     //$list['rows'][$key] = $value;
            
        // }
        
        $this->returnSuccess($list);
        
    }

    public function loadUsers(){
        
        $shopUserModel = new \model\ShopUser();
        $list = $shopUserModel->getShopUserList();
        $this->returnSuccess($list);
    }
    
}
