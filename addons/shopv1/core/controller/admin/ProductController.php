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
    
    public function saveProductStore(){
        
    }
    
    public function loadProductType(){
        $uniacid = $this->getUniacid();
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function saveProductType(){
        
    }
    
    public function loadProduct(){
        
    }
    
    public function saveProduct(){
        
    }
    
}
