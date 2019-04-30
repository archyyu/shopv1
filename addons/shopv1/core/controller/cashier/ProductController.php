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
        
        $typeid = $this->getParam("type");
        $shopid = $this->getParam("shopid");
        
        $list = $this->productService->getProductList($shopid, $typeid);
        
        $this->returnSuccess($list);
    }
    
    public function loadProductInventory(){
        
        $shopid = $this->getParam("shopid");
        $list = $this->productService->getProductListByShop($shopid);
        $this->returnSuccess($list);
    }
    
    //盘点
    public function inventorycheck(){
        
        $shopid = $this->getParam("shopid");
        $userid = $this->getParam("userid");
        //logInfo("data：". htmlspecialchars_decode($this->getParam("data")));
        $productList = json_decode( htmlspecialchars_decode( $this->getParam("data") ), true);
        $shop = $this->shopModel->findShopById($shopid);
        
        foreach($productList as $key=>$value){
            
            $this->productService->inventoryCheck($shop['uniacid'], $shopid, $value['id'], $value['actualinventory'],
                $shop['defaultstoreid'], $userid);
            
        }
        
        $this->returnSuccess();
        
    }
    
    public function mobileshift(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('mobilemain.tpl');
    }
    
    public function mobilecount(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('mobilemain.tpl');
    }
    
    public function mobilewaterbar(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('mobilemain.tpl');
    }
    
    
    
    
    
}
