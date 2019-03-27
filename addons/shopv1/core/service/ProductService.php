<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

use model\Shop;
use model\ShopProduct;
use model\ShopProductrelation;
use model\ShopProductInventory;
use model\ShopInventorylog;
use common\ProductType;


/**
 * Description of ProductService
 *
 * @author YJP
 */
class ProductService extends Service{
    //put your code here
    
    private $productModel;
    
    private $productInventoryModel;
    
    private $inventorylogModel;
    
    private $shopModel;
    
    private $productrelationModel;
    
    
    public function __construct() {
        $this->productModel = new ShopProduct();
        $this->shopModel = new Shop();
        $this->productInventoryModel = new ShopProductInventory();
        $this->inventorylogModel = new ShopInventorylog();
        $this->productrelationModel = new ShopProductrelation();
    }
    
    public function addProductSale($productId,$productNum){
        
        $productBean = $this->productModel->findProdudctById($productId);
        if(isset($productBean)){
            
            $data = array();
            $data["salenum"] = $productBean["salenum"] + $productNum;
            $this->productModel->updateProductById($data, $productId);
            
        }
        
    }
    
    public function subProdudctInventory($shopid,$productId,$productNum,$type){
        
        $shop = $this->shopModel->findShopById($shopid);
        $product = $this->productModel->findProdudctById($productId);
        
        if(isset($product) == false){
            return 0;
        }
        if(isset($shop) == false){
            return 0;
        }
        
        if($product['producttype'] == ProductType::VirtualProduct){
            return 1;
        }
        
        if($product['producttype'] == ProductType::FinishProduct){
            return $this->subMatrialInventory($shopid, $productId, $shop['defaultstoreid'], $productNum);
        }
        
        if($product['producttype'] == ProductType::SelfMadeProduct){
            
            $list = $this->productrelationModel->getRelationList($productId);
            foreach($list as $relation){
                $this->subMatrialInventory($shopid, $relation['materialid'], $shop['defaultstoreid'], $relation['num'],$type);
            }
            
        }
    }
    
    public function findInventoryBy($shopid,$productid,$storeid){
        $productInventory = $this->productInventoryModel->find($productid, $storeid);
        if(isset($productInventory)){
            return $productInventory;
        }
        
        $productInventory = array();
        $productInventory['shopid'] = $shopid;
        $productInventory['productid'] = $productid;
        $productInventory['storeid'] = $storeid;
        $productInventory['inventory'] = 0;
        
        $this->productInventoryModel->add($productInventory);
        
        return $productInventory;
    }
    
    public function subMatrialInventory($shopId,$materialId,$storeId,$num,$type){
        
        $materialInventory = $this->findInventoryBy($shopId,$materialId, $storeId);
        
        $data = array();
        $data['inventory'] = $materialInventory['inventory'] + $num;
        $this->productInventoryModel->updateProductInventory($data, $materialId,$storeId);
        
        $logData = array();
        $logData['shopid'] = $shopId;
        $logData['productid'] = $materialId;
        $logData['storeid'] = $storeId;
        $logData['num'] = $num;
        $logData['logtype'] = $type;
        $logData['createtime'] = time();
        $this->inventorylogModel->add($logData);
    }
    
}
