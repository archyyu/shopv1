<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

use model\ShopOrder;

/**
 * Description of DutyController
 *
 * @author YJP
 */
class DutyController extends \controller\Controller{
    
    private $dutyModel;
    
    private $userModel;

    private $orderModel;
    
    public function __construct() {
        parent::__construct();
        $this->dutyModel = new \model\ShopDuty();
        $this->userModel = new \model\ShopUser();
        $this->orderModel = new ShopOrder();
    }
    
    public function index(){
        $this->smarty->display("admin/duty.tpl");
    }
    
    public function loadDutys(){
        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $where = array();
        $where['uniacid'] = $uniacid;
        $where["shopid"] = $shopid;
        
        $userMap = $this->userModel->getUserMap($uniacid);
        $shopMap = $this->shopModel->findShopMapByUnacid($uniacid);
        
        $data = $this->dutyModel->page($offset,$limit,"*",$where,"id");
        
        foreach($data['rows'] as $key=>$value){
            $data['rows'][$key]['shopname'] = $shopMap[$value['shopid']]['shopname'];
            $data['rows'][$key]['username'] = $userMap[$value['userid']]['account'];
        }
        
        $this->returnSuccess($data);
        
    }


    public function loadDutyProductList(){

        //$shopid = $this->getParam("shopid");
        $dutyid = $this->getParam("dutyid");

        $duty = $this->dutyModel->selectDutyById($dutyid);
        $starttime = $duty["starttime"];
        $endtime = $duty['endtime'];

        logInfo("duty: starttime $starttime endtime:$endtime");

        $orderList = $this->orderModel->findShopOrderList($duty["shopid"], $starttime, $endtime);

        $productlist = array();

        foreach($orderList as $key=>$value){

            $productinfo = json_decode($value['orderdetail']);

            foreach($productinfo as $key=>$productinfovalue)
            {
                $productid = $productinfovalue->productid;

                if(isset($productlist[$productid]) == false){
                    $item = array();

                    $item['productid'] = $productid;
                    $item['productname'] = $productinfovalue->productname;
                    $item["num"] = $productinfovalue->num;
                    $item['sum'] = $productinfovalue->num*$productinfovalue->price;
                    $item['price'] = $productinfovalue->price;

                }
                else{
                    $item = $productlist[$productid];

                    $item['productid'] = $productid;
                    $item["num"] += $productinfovalue->num;
                    $item['sum'] += $productinfovalue->num*$productinfovalue->price;
                    $item['price'] = $productinfovalue->price;

                }

                $productlist[$productid] = $item;

            }

        }

        //$typeMap = $this->productTypeModel->getProductTypeMap($uniacid);

        $list = array();
        foreach($productlist as $key=>$value){
            $value['producttype'] = "-";
            $list[] = $value;
        }

        $this->returnSuccess($list);

    }
    
    
    
}
