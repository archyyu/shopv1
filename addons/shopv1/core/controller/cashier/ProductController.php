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
    
    private $shopStock;
    
    private $shopStore;
    
    private $shopStockProduct;
    
    private $cardTypeModel;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new ShopProduct();
        $this->shopStore = new \model\ShopStore();
        $this->shopStock = new \model\ShopStock();
        $this->shopStockProduct = new \model\ShopStockProduct();
        $this->cardTypeModel = new \model\ShopCardtype();
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
    
    public function queryShopStoreList(){
        
        $shopid = $this->getParam("shopid");
        
        $shop = $this->shopModel->findShopById($shopid);
        $storeList = $this->shopStore->getStoreListByShopid($shopid);
        
        $result = array();
        $result["list"] = $storeList;
        $result["defaultstoreid"] = $shop["defaultstoreid"];
        
        $this->returnSuccess($result);
    }
    
    public function loadProductInventory(){
        
        $shopid = $this->getParam("shopid");
        $storeid = $this->getParam("storeid");
        $list = $this->productService->getProductListByShop($shopid,$storeid);
        $this->returnSuccess($list);
    }
    
    //盘点
    public function inventorycheck(){
        
        $shopid = $this->getParam("shopid");
        $userid = $this->getParam("userid");
        $storeid = $this->getParam("storeid");
        //logInfo("data：". htmlspecialchars_decode($this->getParam("data")));
        $productList = json_decode( htmlspecialchars_decode( $this->getParam("data") ), true);
        $shop = $this->shopModel->findShopById($shopid);
        
        foreach($productList as $key=>$value){
            
            $this->productService->inventoryCheck($shop['uniacid'], $shopid, $value['id'], $value['actualinventory'],
                $storeid, $userid);
            
        }
        
        $this->returnSuccess();
    }
    
    public function queryCardTypeList(){
        $uniacid = $this->getUniacid();
        $cardTypeList = $this->cardTypeModel->getCardTypeList($uniacid);
        $this->returnSuccess($cardTypeList);
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
    
    public function mobileuser(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/mobile');
        $this->smarty->display('usermain.tpl');
    }
    
    public function clientsidebar(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/client');
        $this->smarty->display('sidebar.tpl');
    }
    
    public function clientwaterbar(){ 
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/client');
        $this->smarty->display('waterbar.tpl');
    }
    
    public function backside(){
        
        $this->smarty->setTemplateDir(CASHROOT . 'template/backside');
        $this->smarty->display('backside.tpl');
    }
    
    
    
    
    
}
