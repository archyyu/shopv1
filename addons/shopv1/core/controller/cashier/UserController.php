<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

/**
 * Description of UserController
 *
 * @author YJP
 */
class UserController extends \controller\Controller{
    
    private $userModel;
     
    
    public function __construct() {
        parent::__construct();
        $this->userModel = new \model\ShopUser(); 
    }
    
    public function login(){
        
        $account = $this->getParam("account");
        $password = $this->getParam("password");
        
        $user = $this->userModel->getShop($account, md5($password));
        
        if(isset($user)){
            
            $result = array();
            $result['user'] = $user;
            $result['shop'] = $this->shopModel->findShopById($user['shopid']);
            
            $this->returnSuccess($result);
        }
        else{
            $this->returnFail("账号或者密码错误");
        }
    }
    
}
