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
    
    private $cardTypeModel;
    
    public function __construct() {
        parent::__construct();
        $this->cardTypeModel = new \model\ShopCardtype();
    }
    
    //卡券管理
    public function index(){
        $this->smarty->display('admin/card/cardmanagement.tpl');
    }
    
    public function loadCardTypeList(){
        $uniacid = $this->getUniacid();
        $list = $this->cardTypeModel->getCardTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function saveCardType(){
        
        
        
    }
    
    //卡券流水
    public function logIndex(){
        $this->smarty->display('admin/card/cardflow.tpl');
    }
    
    
}
