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
        
    }
    
    public function index(){
        $uniacid = $this->getUniacid();
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        $storelist = $this->storeModel->getStoreListByUniacid($uniacid);
        $this->smarty->assign("typelist",$typelist);
        $this->smarty->assign("storelist",$storelist);
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
    
    public function loadProduct(){
        $uniacid = $this->getUniacid();
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        
        $map = array();
        foreach ($typelist as $key=>$value){
            $map[$value['id']] = $value;
            //logInfo($value[id].":".$value["typename"]);
        }
        
        
        
        $productList = $this->productModel->findProductByUniacid($uniacid);
        
        foreach($productList as $k=>$v){
            $productList[$k]['typename'] = $map[$v['typeid']]['typename'];
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
        }
        else{
            $result = $this->productModel->updateProductById($data, $productid);
            $this->productRelateModel->deleteRelation($productid);
        }
        $productlinks = json_decode( $this->getParam("productlink") );
        
        if(isset($productlinks)){
            
            foreach($productlinks as $key=>$value){

                $subproductid = $value['productid'];
                $num = $value['num'];

                $data = array();
                $data["productid"] = $productid;
                $data['materialid'] = $subproductid;
                $data["num"] = $num;

                $this->productRelateModel->addNewRelation($data);
            }
            
        }
        
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("数据库异常");
        }
        
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
    
    public function inventoryTransfer($productid,$inventory,$sourceid,$destinationid){
        $uniacid = $this->getUniacid();
        $this->productService->transferInventory($uniacid, 0, $productid, $inventory, $sourceid, $destinationid, 0);
        return $this->returnSuccess();
    }
    
    public function inventoryDamage($productid,$inventory,$storeid){
        $uniacid = $this->getUniacid();
        $this->productService->inventoryDamage($uniacid, 0, $productid, $inventory, $storeid, 0);
        return $this->returnSuccess();
    }
    
    public function inventoryFlow($productid,$inventory,$storeid){
        $uniacid = $this->getUniacid();
        $this->productService->inventoryFlow($uniacid, 0, $productid, $inventory, $storeid, 0);
        return $this->returnSuccess();
    }
    
    
}
