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
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->storeModel = new \model\ShopStore();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new \model\ShopProduct();
        
    }
    
    public function index(){
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
        
    }
    
    public function saveProduct(){
        
    }
    
}
