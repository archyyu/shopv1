<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

/**
 * Description of DutyController
 *
 * @author YJP
 */
class DutyController extends \controller\Controller{
    
    private $dutyModel;
    
    public function __construct() {
        parent::__construct();
        $this->dutyModel = new \model\ShopDuty();
    }
    
    public function index(){
        
    }
    
    public function loadDutys(){
        
    }
    
    
    
}
