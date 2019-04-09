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
    
    public function removeCardType(){
        $cardid = $this->getParam("cardid");
        
        $data = array();
        $data['id'] = $cardid;
        $data['deleteflag'] = 1;
        
        $result = $this->cardTypeModel->saveCardType($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库错误");
        }
        
    }
    
    public function saveCardType(){
        
        $uniacid = $this->getUniacid();
        $cardid = $this->getParam("cardid");
        $cardname = $this->getParam('cardname');
        $exchange = $this->getParam('exchange');
        $discount = $this->getParam('discount');
        $effectiveprice = $this->getParam('effectiveprice');
        $effectiveday = $this->getParam('effectiveday');
        
        $data = array();
        
        if($cardid == 0){
            $data['uniacid'] = $uniacid;
        }
        else{
            $data['id'] = $cardid;
        }
        
        $data["cardname"] = $cardname;
        $data["exchange"] = $exchange;
        $data["discount"] = $discount;
        $data['effectiveprice'] = $effectiveprice;
        $data['effectiveday'] = $effectiveday;
        
        $result = $this->cardTypeModel->saveCardType($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库错误");
        }
        
    }
    
    //卡券流水
    public function logIndex(){
        $this->smarty->display('admin/card/cardflow.tpl');
    }
    
    
}
