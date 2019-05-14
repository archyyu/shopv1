<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\mobile;

/**
 * Description of UserController
 *
 * @author YJP
 */
class UserController extends \controller\Controller{
    
    private $memberModel;
    
    public function __construct() {
        parent::__construct();
        
        $this->memberModel = new \model\ShopMember();
        
    }
    
    public function index(){
        
        
        
    }
    
    
    
}
