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

    private $memberCardModel;

    private $shopMemberModel;

    private $shopUserModel;

    private $producttypeModel;

    private $productModel;
    
    public function __construct() {
        parent::__construct();
        $this->cardTypeModel = new \model\ShopCardtype();
        $this->memberCardModel = new \model\ShopMemberCard();
        $this->shopMemberModel = new \model\ShopMember();
        $this->shopUserModel = new \model\ShopUser();

        $this->producttypeModel = new \model\ShopProductType();
        $this->productModel = new \model\ShopProduct();
    }
    
    //卡券管理
    public function index(){
        $uniacid = $this->getUniacid();

        $typelist = $this->producttypeModel->getProductTypeList($uniacid);
        $productlist = $this->productModel->findProductByUniacid($uniacid);

        $products = "";
        if (count($productlist) > 0) {
            $products = json_encode($productlist);
        }

        $this->smarty->assign("typelist", $typelist);
        $this->smarty->assign("products", $products);
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
        $typeid = $this->getParam('typeid');
        $productid = $this->getParam('productid');
        $cardtype = $this->getParam('cardtype');
        
        $data = array();
        
        if($cardid == 0){
            $data['uniacid'] = $uniacid;
        }
        else{
            $data['id'] = $cardid;
        }
        
        $data['cardtype'] = $cardtype;
        $data["cardname"] = $cardname;
        $data["exchange"] = $exchange * 100;
        $data["discount"] = $discount;
        $data['effectiveprice'] = $effectiveprice * 100;
        $data['effectiveday'] = $effectiveday;
        $data['typeid'] = $typeid;
        $data['productid'] = $productid;
        
        $result = $this->cardTypeModel->saveCardType($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库错误");
        }
        
    }

    public function saveNetCardType(){
        
        $uniacid = $this->getUniacid();
        $cardid = $this->getParam("cardid");
        $cardname = $this->getParam('cardname');
        $exchange = $this->getParam('exchange');
        $timearea = $this->getParam('timearea');
        $cardtype = $this->getParam('cardtype');
        
        $data = array();
        
        if($cardid == 0){
            $data['uniacid'] = $uniacid;
        }
        else{
            $data['id'] = $cardid;
        }

        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $data['starttime'] = strtotime(trim($timeArr[0]). " 00:00:00");
            $data['endtime'] = strtotime(trim($timeArr[1]). " 00:00:00");
        }
        
        $data['cardtype'] = $cardtype;
        $data["cardname"] = $cardname;
        $data["exchange"] = $exchange * 100;
        $data['effectiveprice'] = 0;
        $data['effectiveday'] = 3;
        
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
        $uniacid = $this->getUniacid();
        $list = $this->cardTypeModel->getCardTypeList($uniacid);
        $this->smarty->assign("cardlist", $list);
        $this->smarty->display('admin/card/cardflow.tpl');
    }
    
    public function loadCardflows()
    {
        // $uniacid = $this->getUniacid();
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $timearea = $this->getParam("timearea");
        $useflag = $this->getParam("useflag");
        $sendshopid = $this->getParam("sendshopid");
        $usedshopid = $this->getParam("usedshopid");
        //$cardtype = $this->getParam("cardtype");
        $cardid = $this->getParam("cardid");

        // $where['uniacid'] = $uniacid;
        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $where['gettime[<>]'] = [strtotime(trim($timeArr[0]). ":00"), strtotime(trim($timeArr[1]) . ":00")];
        }

        if ((int)$useflag != 2) {
            $where['useflag'] = $useflag;
        }

        // if ($cardtype != 2) {
        //     $where['cardtype'] = $cardtype;
        // }

        if ($cardid) {
            $where['cardtype'] = $cardid;
        }

        if ($sendshopid) {
            $where['sendshopid'] = $sendshopid;
        }

        if ($usedshopid) {
            $where['usedshopid'] = $usedshopid;
        }

        $where['deleteflag'] = 0;
        
        $list = $this->memberCardModel->page($offset, $limit, "*", $where, "id");
        
        foreach($list['rows'] as $key=>$value){
            
            $member = $this->shopMemberModel->queryMemberByUid($value['memberid']);
            if ($member){
                $list['rows'][$key]['nickname'] = $member['nickname'];
                $list['rows'][$key]['realname'] = $member['realname'];
                $list['rows'][$key]['phone'] = $member['mobile'];
            }
            else{
                $list['rows'][$key]['nickname'] = '';
                $list['rows'][$key]['realname'] = '';
                $list['rows'][$key]['phone'] = '';
            }

            $user = $this->shopUserModel->getShopUserById($value['memberid']);
            if ($user){
                $list['rows'][$key]['username'] = $user['account'];
            }
            else{
                $list['rows'][$key]['username'] = '';
            }
        }

        $this->returnSuccess($list);

    }
    
    public function deleteCardflow(){
        $id = $this->getParam("id");
        $data['id'] = $id;
        $data['deleteflag'] = 1;

        $this->memberCardModel->saveMemberCard($data);

        $this->returnSuccess();
    }
}
