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
    
    private $inventoryLogModel;
    
    public function __construct() {
        parent::__construct();
        $this->productService = new ProductService();
        $this->storeModel = new \model\ShopStore();
        $this->productTypeModel = new ShopProductType();
        $this->productModel = new \model\ShopProduct();
        $this->productRelateModel = new \model\ShopProductrelation();
        $this->productUnitModel = new \model\ShopProductUnit();
        $this->productInventory = new \model\ShopProductInventory();
        $this->inventoryLogModel = new \model\ShopInventorylog();
        
    }
    
    public function index(){
        $uniacid = $this->getUniacid();
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        $storelist = $this->storeModel->getStoreListByUniacid($uniacid);
        $productlist = $this->productModel->findProductByUniacid($uniacid);

        $products = "";
        if (count($productlist) > 0) {
            $products = json_encode($productlist);
        }

        $this->smarty->assign("typelist",$typelist);
        $this->smarty->assign("storelist",$storelist);
        // $this->smarty->assign('productlist',$productlist);
        $this->smarty->assign('products', $products);
        $this->smarty->display('admin/waterbar/inventory.tpl');
    }
    
    public function store(){
        $this->smarty->display('admin/waterbar/warehouse/warehouse.tpl');
    }
    
    
    public function loadProductStore(){
        $uniacid = $this->getUniacid();
        $shopMap = $this->shopModel->findShopMapByUnacid($uniacid);
        $list = $this->storeModel->getStoreListByUniacid($uniacid);
        
        foreach($list as $key=>$value){    
            $list[$key]['shopname'] = $shopMap[$value['shopid']]['shopname'];
        }
        
        $this->returnSuccess($list);
    }
    
    public function saveStore(){
        $uniacid = $this->getUniacid();
        $storename = $this->getParam('storename');
        $storeid = $this->getParam('storeid');
        $shopid = $this->getParam("shopid");
        
        $data = array();
        $data['uniacid'] = $uniacid;
        $data['storename'] = $storename;
        
        if(isset($shopid)){
            $data['shopid'] = $shopid;
        }
        
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
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        $storeid = $this->getParam("storeid");
        
        $typeid = $this->getParam('typeid');
        
        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        
        $map = array();
        foreach ($typelist as $key=>$value){
            $map[$value['id']] = $value;
        }
        
        $where = array();
        $where['uniacid'] = $uniacid;
        //$where['storeid'] = $storeid;
        
        if(isset($typeid) && $typeid != ''){
            $where['typeid'] = $typeid;
        }
        
        $productData = $this->productModel->page($offset, $limit, '*', $where, 'id');
        $productList = $productData['rows'];
        
        foreach($productList as $k=>$v){
            $productList[$k]['typename'] = $map[$v['typeid']]['typename'];
            
            if($v['producttype'] == 1 || $v['producttype'] == -1 || $v['producttype'] == 3){
                $productList[$k]['inventory'] = '-';
                continue;
            }
            
            $inventory = $this->productService->findInventoryBy(0, $v['id'], $storeid);
            $productList[$k]['inventory'] = $inventory['inventory'];
        }
        
        $productData['rows'] = $productList;
        
        $this->returnSuccess($productData);
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
        $userget = $this->getParam("userget");
        
        $linklist = html_entity_decode($this->getParam("link"));
        logInfo("productid:".$productid);
        logInfo("link:".$this->getParam("link"));
        
        
        $data = array();
        
        if ($_FILES) {
            $upload_res = $this->upload($_FILES['productimg'], 'productlogo');
            if ($upload_res['state'] == 0) {
                $data['productimg'] = $upload_res['saveName'];
            } else {
                $this->ajaxReturn(Code::err($upload_res['msg']));
            }
        }
        else{
            
        }
        
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
        $data['productlink'] = $linklist;
        $data["userget"] = $userget;
        
        $result = false;
        
        if($productid == 0){
            $result = $this->productModel->addProduct($data);
            $productid = $data['lastInsertId'];
        }
        else{
            $result = $this->productModel->updateProductById($data, $productid);
            $this->productRelateModel->deleteRelation($productid);
        }
        
//        foreach($linklist as $key=>$value){
//            logInfo("product relation: $productid,".$value['materialid']." ".$value['num']);
//            $this->productRelateModel->addRelation($productid, $value['materialid'], $value['num']);
//        }
        
        
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
        $uniacid = $this->getUniacid();
        $productlist = $this->productModel->findProductByUniacid($uniacid);

        // foreach ($productlist as $key => $value) {
            
        // }

        $typelist = $this->productTypeModel->getProductTypeList($uniacid);
        
        $types = "";
        if (count($typelist) > 0) {
            $types = json_encode($typelist);
        }

        $storelist = $this->storeModel->getStoreListByUniacid($uniacid);

        $this->smarty->assign("productlist", $productlist);
        $this->smarty->assign("types", $types);
        $this->smarty->assign("storelist", $storelist);
        $this->smarty->display('admin/waterbar/batchstock.tpl');
    }

    public function saveStockOrder(){
        $uniacid = $this->getUniacid();
        $userid = $this->getUserid();

        $storage = $this->getParam("storage");
        $productJson = $this->getParam("productJson");
        $remark = $this->getParam("remark");
        $discount = $this->getParam("discount");
        $payprice = $this->getParam("payprice");

        $store = $this->storeModel->findStoreById($storage);
        if (!$store) {
            $this->returnFail("未找到此库房");
            return ;
        }

        $shopid = $store['shopid'];

        $data = [];
        $data['storageid'] = $storage;
        $data['remark'] = $remark;
        $data['productJson'] = json_encode($productJson);
        $data['remark'] = $remark;
        $data['createtime'] = time();
        $data['discount'] = $discount;
        $data['payprice'] = $payprice;
        $data['userid'] = $userid;
        $data['shopid'] = $shopid;
        $data['uniacid'] = $uniacid;

        $shopStockOrderModel = new \model\ShopStockOrder();
        try {
            $shopStockOrderModel->beginTransaction();
            $stockorderid = $shopStockOrderModel->addStockOrder($data);
            if ($stockorderid == 0) {
                logInfo("进货失败：" . json_encode($productJson));
                $shopStockOrderModel->rollback();
                
                $this->returnFail("进货失败，数据异常");
                return ;
            }

            foreach ($productJson as $key => $value) {
                $this->productService->inventoryStock($uniacid,$shopid,$value['id'],$value['num'],$storage,$userid,$stockorderid);
            }
            $shopStockOrderModel->commit();
            
            $this->returnSuccess();
            return ;

        } catch (Exception $e) {
            logError("进货失败", $e);
            $shopStockOrderModel->rollback();
            
            $this->returnFail("进货失败");
            return ;
        }
        
    }

    public function transformIndex(){
        $uniacid = $this->getUniacid();
        $productlist = $this->productModel->findProductByUniacid($uniacid);
        $storelist = $this->storeModel->getStoreListByUniacid($uniacid);

        $this->smarty->assign("productlist", $productlist);
        $this->smarty->assign("storelist", $storelist);
        $this->smarty->display("admin/waterbar/transform.tpl");
    }

    public function saveBatchShipment(){
        $uniacid = $this->getUniacid();
        $userid = $this->getUserid();

        $sourceid = $this->getParam("sourceid");
        $destinationid = $this->getParam("destinationid");
        $productJson = $this->getParam("productJson");
        $remark = $this->getParam("remark");

        $store = $this->storeModel->findStoreById($sourceid);
        if (!$store) {
            $this->returnFail("未找到此库房");
            return ;
        }

        $shopid = $store['shopid'];


        $this->productInventory->beginTransaction();
        try {

            foreach ($productJson as $key => $value) {
                $this->productService->transferInventory($uniacid,$shopid,$value['id'],$value['num'],$sourceid,$destinationid,$userid);
            }
            $this->productInventory->commit();
            
            $this->returnSuccess();
            return ;

        } catch (Exception $e) {
            logError("调货失败", $e);
            $this->productInventory->rollback();
            
            $this->returnFail("调货失败");
            return ;
        }
    }
    
    public function inventorylog(){
        $this->smarty->display("admin/waterbar/inventorylog.tpl");
    }
    
    public function loadlogs(){
        $uniacid = $this->getUniacid();
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");
        
        $where["uniacid"] = $uniacid;
        
        $productMap = $this->productModel->findProductMapByUniacid($uniacid);
        $storeMap = $this->storeModel->getStoreMapByUnacid($uniacid);
        
        $list = $this->inventoryLogModel->page($offset, $limit, "*", $where,"id");
        
        foreach($list['rows'] as $key=>$value){
            $list['rows'][$key]['productname'] = $productMap[$value['productid']]['productname'];
            $list['rows'][$key]['storename'] = $storeMap[$value['storeid']]['storename'];
        }
        
        $this->returnSuccess($list);
        
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }
    
    public function memberlist(){
        $this->smarty->display("admin/member/memberList.tpl");
    }
    
}
