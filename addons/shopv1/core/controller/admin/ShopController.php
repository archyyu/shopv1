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
        
    }
    
    public function save(){
        
    }
    
}
