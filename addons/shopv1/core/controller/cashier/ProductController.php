<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

use service\ProductService;
use model\ShopProductType;
use model\ShopProduct;

/**
 * Description of ProductController
 *
 * @author YJP
 */
class ProductController extends \controller\Controller{
    
    private $productService;
    
    private $productTypeModel;
    
    private $productModel;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new ShopProduct();
    }
    
    public function index(){
        // echo "cashier index";
        $this->smarty->display('cashier/cashiermain.tpl');
    }
    
    public function loadProductTypeList(){
        $shopid = $this->getParam('shopid');
        $uniacid = $this->productService->getUniacidByShopId($shopid);
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        
        $shopid = $this->getParam("shopid");
        $typeid = $this->getParam("typeid");
        
        $this->productModel->findProductByType($typeid);
    }
    
    
    
}
