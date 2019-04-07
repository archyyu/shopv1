<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller;

use controller\Controller;

/**
 * Description of IndexController
 *
 * @author YJP
 */
class WaterbarController extends Controller{
    //put your code here
    
    public function index(){
        $this->smarty->display('waterbar/inventory.tpl');
    }
    
    public function warehouse(){
        $this->smarty->display('waterbar/warehouse/warehouse.tpl');
    }
    
    
}
