<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

/**
 * Description of CardController
 *
 * @author YJP
 */
class CardController extends \controller\Controller{
    
    public function __construct() {
        parent::__construct();
    }
    
    //卡券管理
    public function index(){
        echo "卡券管理";
    }
    
    //卡券流水
    public function logIndex(){
        echo "卡券流水";
    }
    
}
