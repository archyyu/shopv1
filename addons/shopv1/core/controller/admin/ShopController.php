<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

use controller\Controller;

/**
 * Description of ShopController
 *
 * @author YJP
 */
class ShopController extends Controller{
    //put your code here
    
    public function __construct() {
        parent::__construct();
    }
    
    public function index(){
        $this->smarty->display('admin/shopinfo.tpl');
    }
    
    public function loadShopList(){
        try{
            $list = $this->shopModel->findShopListByUniacid($this->getUniacid());
            $this->returnSuccess($list);
        }
        catch (Exception $ex){
            logError("err", $ex);
        }
    }
    
    public function save(){
        
        $sid = $this->getParam('shopid');
        $shopname = $this->getParam("shopname");
        $master = $this->getParam('master');
        $phone = $this->getParam('phone');
        $detail = $this->getParam('detail');
        $address = $this->getParam('address');
        
        $data = array();
        $data['shopname'] = $shopname;
        $data['master'] = $master;
        $data['phone'] = $phone;
        $data['detail'] = $detail;
        $data['address'] = $address;
        $data['uniacid'] = $this->getUniacid();
        
        if(isset($sid)){
            $data['id'] = $sid;
        }
        
        $result = $this->shopModel->saveShop($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("保存错误");
        }
        
    }
    
}
