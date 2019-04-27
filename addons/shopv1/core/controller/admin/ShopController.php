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
    
    private $userModel;
    
    private $storeModel;
    
    public function __construct() {
        parent::__construct();
        $this->userModel = new \model\ShopUser();
        $this->storeModel = new \model\ShopStore();
    }
    
    public function index(){
        $this->smarty->display('admin/shopinfo.tpl');
    }
    
    public function staffIndex(){
        $this->smarty->display('admin/staff.tpl');
    }
    
    public function loadStaffList(){
        try{
            $offset = $this->getParam('offset');
            $limit = $this->getParam('limit');
            $shopid = $this->getParam('shopid');
            
            $where['shopid'] = $shopid;
            $data = $this->userModel->page($offset,$limit,'*',$where,'id');
            //$list = $this->userModel->getShopUserList($shopid);
            
            $this->returnSuccess($data);
        
        }
        catch (Exception $e){
            logError("error", $e);
        }
        
    }
    
    public function saveStaff(){
        
        $userid = $this->getParam('userid');
        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");
        $password = $this->getParam("password");
        $sex = $this->getParam("sex");
        $account = $this->getParam("account");
        $phone = $this->getParam("phone");
        $openid = $this->getParam("openid");
        
        $data = array();
        
        if($userid == 0){
            $data['password'] = md5($password);            
        }
        else{
            $data['id'] = $userid;
        }
        
        $data['uniacid'] = $uniacid;
        $data['shopid'] = $shopid;
        $data['account'] = $account;
        $data['sex'] = $sex;
        $data['openid'] = $openid;
        $data["phone"] = $phone;
        
        if($this->userModel->saveUser($data)){
            $this->returnSuccess();
        }
        else{
            
            $this->returnFail("数据库内部错误");
        }
        
    }
    
    public function loadShopList(){
        try{
            $uniacid = $this->getUniacid();
            $offset = $this->getParam('offset');
            $limit = $this->getParam('limit');
            
            $where = array();
            $where['uniacid'] = $uniacid;
            
            $data = $this->shopModel->page($offset,$limit,'*',$where,'id');
            
            $this->returnSuccess($data);
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
        
        if(isset($sid) == false){
            //新建门店
            $sid = $data["lastInsertId"];
            //创建默认库房
            
            $storeid = $this->storeModel->addStore($shopname."的库房", $sid,  $data['uniacid']);
            
            $newData = array();
            $newData['id'] = $sid;
            $newData['defaultstoreid'] = $storeid;
            
            $this->shopModel->saveShop($newData);
            
        }
        
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("保存错误");
        }
        
    }
    
}
