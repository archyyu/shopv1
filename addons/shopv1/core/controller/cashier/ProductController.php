<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\cashier;

use model\ShopBroadCast;
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
    
    private $bannerModel;
    
    private $memberModel;
    
    private $cardService;
    
    private $cardModel;

    private $shopBroadCastModel;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new ShopProduct();
        $this->shopStore = new \model\ShopStore();
        $this->shopStock = new \model\ShopStock();
        $this->shopStockProduct = new \model\ShopStockProduct();
        $this->cardTypeModel = new \model\ShopCardtype();
        $this->bannerModel = new \model\ShopBanner();
        $this->memberModel = new \model\ShopMember();
        $this->cardService = new \service\CardService();
        $this->cardModel = new \model\ShopMemberCard();
        $this->shopBroadCastModel = new ShopBroadCast();
    }
    
    public function index(){
        // echo "cashier index";
        $this->smarty->display('cashier/cashiermain.tpl');
    }
    
    public function loadProductTypeList(){
        
        $uniacid = $this->getUniacid();
        
        if(isset($uniacid) == false){
            $shopid = $this->getParam('shopid');
            $uniacid = $this->productService->getUniacidByShopId($shopid);
        }
        
        $list = $this->productTypeModel->getProductTypeList($uniacid);
        $this->returnSuccess($list);
    }
    
    public function loadProduct(){
        
        $typeid = $this->getParam("type");
        $shopid = $this->getParam("shopid");
        
        $list = $this->productService->getProductList($shopid, $typeid);
        
        $this->returnSuccess($list);
    }
    
    public function queryProductByCode(){
        
        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");
        $barcode = $this->getParam("code");
        
        $one = $this->productService->getProduct($shopid, $barcode);
        
        if(isset($one)){
            $this->returnSuccess($one);
        }
        
        $this->returnFail("不存在");
        
    }

    public function queryProductByName(){

        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");
        $name = $this->getParam("name");

        $list = $this->productService->findProductByName($shopid,$name);
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
    
    
    public function sendMemberCard(){
        
        $uniacid = $this->getUniacid();
        $userid = $this->getParam("userid");
        $phone = $this->getParam("phone");
        $cardtypeid = $this->getParam("cardtypeid");
        $num = $this->getParam("num");
        
        $member = $this->memberModel->quertyMember(2, $phone);
        
        if(isset($member)){
            
            $this->cardService->sendMemberCard($userid, $cardtypeid, $member['uid'],$num);
            
            $this->returnSuccess();
            
        }
        else{
            $this->returnFail("没有这个用户");
        }
        
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
        
        global $_W;
        $config = $_W['config']['setting']['redis'];

        $this->smarty->setTemplateDir(CASHROOT . 'template/client');
        $this->smarty->display('waterbar.tpl');
    }
    
    public function backside(){
        $this->smarty->setTemplateDir(CASHROOT . 'template/backside');
        $this->smarty->display('backside.tpl');
    }
    
    public function loadbanner(){
        
        $shopid = $this->getParam("shopid");
        $list = $this->bannerModel->getBannerList($shopid);
        $this->returnSuccess($list);
        
    }

    public function loadBroadCastList(){

        $shopid = $this->getParam("shopid");
        $list = $this->shopBroadCastModel->getBroadCastList($shopid);
        $this->returnSuccess($list);

    }

    public function addBroadCast(){

        $shopid = $this->getParam("shopid");
        $content = $this->getParam("content");
        $broadcasttype = $this->getParam("broadcasttype");
        $time = $this->getParam("time");

        $data = array();
        $data["shopid"] = $shopid;
        $data["content"] = $content;
        $data["time"] = $time;
        $data['broadcasttype'] = $broadcasttype;

        $this->shopBroadCastModel->addBroadCast($data);

        $this->returnSuccess();
    }

    public function removeBroadCast(){

        $id = $this->getParam("id");
        $this->shopBroadCastModel->removeBroadCast($id);
        $this->returnSuccess();

    }
    
    
}
