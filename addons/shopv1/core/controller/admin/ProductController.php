<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;

use model\ShopStore;
use model\ShopProductType;
use controller\Controller;
use service\ProductService;


/**
 * Description of ProductController
 *
 * @author YJP
 */
class ProductController extends Controller{
    //put your code here
    
    private $productService;
    
    private $storeModel;
    
    private $productTypeModel;
    
    private $productModel;
    
    private $productInventory;
    
    private $productRelateModel;
    
    private $productUnitModel;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->storeModel = new \model\ShopStore();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new \model\ShopProduct();
        $this->productRelateModel = new \model\ShopProductrelation();
        $this->productUnitModel = new \model\ShopProductUnit();
        $this->productInventory = new \model\ShopProductInventory();
        
    }
    
    public function index(){
        $uniacid = $this->getUniacid();
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        $storelist = $this->storeModel->getStoreListByUniacid($uniacid);
        $productlist = $this->productModel->findProductByUniacid($uniacid);
        $this->smarty->assign("typelist",$typelist);
        $this->smarty->assign("storelist",$storelist);
        $this->smarty->assign('productlist',$productlist);
        $this->smarty->display('admin/waterbar/inventory.tpl');
    }
    
    public function store(){
        $this->smarty->display('admin/waterbar/warehouse/warehouse.tpl');
    }
    
    
    public function loadProductStore(){
        $uniacid = $this->getUniacid();
        $list = $this->storeModel->getStoreListByUniacid($uniacid);
        $this->returnSuccess($list);
    }
    
    public function saveStore(){
        $uniacid = $this->getUniacid();
        $storename = $this->getParam('storename');
        $storeid = $this->getParam('storeid');
        
        $data = array();
        $data['uniacid'] = $uniacid;
        $data['storename'] = $storename;
        $data['deleteflag'] = 0;
        
        if(isset($storeid)){
            $data['id'] = $storeid;
        }
        else{
            $data['createdate'] = date("Y-m-d H:i:s");
        }
        
        if($this->storeModel->saveStore($data)){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库错误");
        }
    }
    
    public function loadProductType(){
        $uniacid = $this->getUniacid();
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        
        $this->returnSuccess($list);
    }
    
    public function saveProductType(){
        
        $uniacid = $this->getUniacid();
        $typeid = $this->getParam("typeid");
        $pos = $this->getParam("pos");
        $typename = $this->getParam("typename");
        
        $data = array();
        
        if($typeid == 0){
            
        }
        else{
            $data['id'] = $typeid;
        }
        $data["pos"] = $pos;
        $data["uniacid"] = $uniacid;
        $data["typename"] = $typename;
        
        $result = $this->productTypeModel->saveProductType($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("内部错误");
        }
        
    }
    
    public function inventorylist(){
        $productid = $this->getParam('productid');
        $list = $this->productInventory->findInventoryListByProductId($productid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        $uniacid = $this->getUniacid();
        
        $storeid = $this->getParam("storeid");
        
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        
        $map = array();
        foreach ($typelist as $key=>$value){
            $map[$value['id']] = $value;
        }
        
        $productList = $this->productModel->findProductByUniacid($uniacid);
        
        foreach($productList as $k=>$v){
            $productList[$k]['typename'] = $map[$v['typeid']]['typename'];
            
            if($v['producttype'] == 1 || $v['producttype'] == -1 || $v['producttype'] == 3){
                $productList[$k]['inventory'] = '-';
                continue;
            }
            
            $inventory = $this->productService->findInventoryBy(0, $v['id'], $storeid);
            $productList[$k]['inventory'] = $inventory['inventory'];
        }
        
        $this->returnSuccess($productList);
    }
    
    public function saveProduct(){
        $productid = $this->getParam("productid");
        $productname = $this->getParam("productname");
        $productcode = $this->getParam("productcode");
        
        $typeid = $this->getParam("typeid");
        $producttype = $this->getParam("producttype");
        $normalprice = $this->getParam("normalprice");
        $memberprice = $this->getParam("memberprice");
        $make = $this->getParam("make");
        $attributes = $this->getParam("attributes");
        $unit = $this->getParam("unit");
        $index = $this->getParam("index");
        
        $linklist = json_decode(html_entity_decode($this->getParam("link")),true);
        logInfo("productid:".$productid);
        logInfo("link:".$this->getParam("link"));
        
        
        $data = array();
        
        $data["uniacid"] = $this->getUniacid();
        $data["productname"] = $productname;
        $data["productcode"] = $productcode;
        $data["typeid"] = $typeid;
        $data['producttype'] = $producttype;
        $data["normalprice"] = $normalprice;
        $data["memberprice"] = $memberprice;
        $data["make"] = $make;
        $data["unit"] = $unit;
        $data["index"] = $index;
        $data["attributes"] = $attributes;
        
        $result = false;
        
        if($productid == 0){
            $result = $this->productModel->addProduct($data);
            $productid = $data['lastInsertId'];
        }
        else{
            $result = $this->productModel->updateProductById($data, $productid);
            $this->productRelateModel->deleteRelation($productid);
        }
        
        foreach($linklist as $key=>$value){
            logInfo("product relation: $productid,".$value['materialid']." ".$value['num']);
            $this->productRelateModel->addRelation($productid, $value['materialid'], $value['num']);
        }
        
        
        $this->returnSuccess();
       
        
    }
    
    public function loadProductUnit(){
        $productid = $this->getParam('productid');
        $product = $this->productModel->findProdudctById($productid);
        $list = $this->productUnitModel->getProductUnitList($productid);
        
        foreach ($list as $key=>$value){
            $list[$key]['productname'] = $product['productname'];
            $list[$key]['unit'] = $product['unit'];
        }
        
        $this->returnSuccess($list);
    }
    
    public function saveProductUnit(){
        $productid = $this->getParam('productid');
        $unitname = $this->getParam('unitname');
        $num = $this->getParam('num');
        
        $data = array();
        $data['productid'] = $productid;
        $data['unitname'] = $unitname;
        $data['num'] = $num;
        
        if($this->productUnitModel->saveProductUnit($data)){
            $this->returnSuccess();
        }
        else{
            $this->returnFail('数据库错误');
        }
        
    }
    
    public function inventoryStock(){
        $uniacid = $this->getUniacid();
        $storeid = $this->getParam('storeid');
        $stockid = $this->getParam('stockid');
        $userid = $this->getUserid();
        
        
        $list = json_encode($this->getParam('list'));
        
        foreach($list as $key=>$value){
            $productid = $value['productid'];
            $num = $value['num'];
            $this->productService->inventoryStock($uniacid, 0, $productid, $num, $storeid, $userid, $stockid);
        }
        
        $this->returnSuccess();
        
    }
    
    public function productStock(){
        
        $uniacid = $this->getUniacid();
        $storeid = $this->getParam('storeid');
        $productid = $this->getParam("productid");
        $num = $this->getParam('inventory');
        $userid = $this->getUserid();
        $stockid = "";
        
        $this->productService->inventoryStock($uniacid, 0, $productid, $num, $storeid, $userid, $stockid);
        $this->returnSuccess();
    }
    
    public function productCheck(){
        $uniacid = $this->getUniacid();
        $storeid = $this->getParam('storeid');
        $productid = $this->getParam("productid");
        $num = $this->getParam('inventory');
        $userid = $this->getUserid();
        
        $this->productService->inventoryCheck($uniacid, 0, $productid, $num, $storeid, $userid);
        $this->returnSuccess();
    }
    
    public function inventoryCheck(){
        
        $uniacid = $this->getUniacid();
        $storeid = $this->getParam('storeid');
        $userid = $this->getUserid();
        
        $list = json_decode($this->getParam('list'));
        
        foreach ($list as $key=>$value){
            $productid = $value['productid'];
            $num = $value['num'];
            $this->productService->inventoryCheck($uniacid, 0, $productid, $num, $storeid, $userid);
        }
        
        return $this->returnSuccess();
        
    }
    
    public function inventoryTransfer(){
        $productid = $this->getParam('productid');
        $inventory = $this->getParam("inventory");
        $sourceid = $this->getParam("sourceid");
        $destinationid = $this->getParam("destinationid");
        
        $uniacid = $this->getUniacid();
        $userid = $this->getUserid();
        
        $this->productService->transferInventory($uniacid, 0, $productid, $inventory, $sourceid, $destinationid, $userid);
        return $this->returnSuccess();
    }
    
    public function inventoryChange(){
        $productid = $this->getParam('productid');
        $storeid = $this->getParam('storeid');
        $inventory = $this->getParam("num");
        $userid = $this->getParam("userid");
        
        if($inventory > 0){
            $this->inventoryFlow($productid, $inventory, $storeid,$userid);
        }
        else{
            $this->inventoryDamage($productid, abs($inventory), $storeid,$userid);
        }
        
    }
    
    public function inventoryDamage($productid,$inventory,$storeid,$userid){
        $uniacid = $this->getUniacid();
        $this->productService->inventoryDamage($uniacid, 0, $productid, $inventory, $storeid, $userid);
        return $this->returnSuccess();
    }
    
    public function inventoryFlow($productid,$inventory,$storeid,$userid){
        
        $uniacid = $this->getUniacid();
        $this->productService->inventoryFlow($uniacid, 0, $productid, $inventory, $storeid, $userid);
        return $this->returnSuccess();
        
    }
    
    public function stock(){
        $this->smarty->display('admin/waterbar/batchstock.tpl');
    }
    
    
    
}
