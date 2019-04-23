<?php /*
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
use model\ShopProductType;
use common\ProductType;


/**
 * Description of ProductService
 *
 * @author YJP
 */
class ProductService extends Service{
    //put your code here
    
    private $productModel;
    
    private $productTypeModel;
    
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
        $this->productTypeModel = new ShopProductType();
    }
    
    public function getUniacidByShopId($shopid){
        $shop = $this->shopModel->findShopById($shopid);
        return $shop['uniacid'];
    }
    
    public function getProductTypeList($unacid){
        $list = $this->productTypeModel->getProductTypeList($unacid);
        return $list;
    }
    
    public function getProductList($shopid,$typeid){
        $shop = $this->shopModel->findShopById($shopid);
        $list = $this->productModel->findProductByType($typeid);
        
        foreach($list as $key=>$product){
            $list[$key]['inventory'] = $this->calculateTheInventory($shop,$product);
        }
        
        return $list;
        
    }
    
    private function calculateTheInventory($shop,$product){
        if($product['producttype'] == ProductType::VirtualProduct){
            return 10000;
        }
        
        if($product['producttype'] == ProductType::FinishProduct){
            return $product['inventory'];
        }
        
        if($product['producttype'] == ProductType::SelfMadeProduct){
            //如果是自制，则计算能制作多少
            $maxcnt = 100;
            $productMaterialList = $this->productrelationModel->getRelationList($product['id']);
            foreach($productMaterialList as $key=>$value){
                
                $inventory = $this->findInventoryBy($shop['id'], $value['materialid'], $shop['defaultstoreid']);
                
                if($value['num'] == 0){
                    continue;
                }
                
                if($inventory['inventory']/$value['num'] < $maxcnt){
                    $maxcnt = $inventory['inventory']/$value['num'];
                }   
            }   
            return $maxcnt;
        }   
        
        return 0;
    }
    
    public function addProductSale($productId,$productNum){
        
        $productBean = $this->productModel->findProdudctById($productId);
        if(isset($productBean)){
            
            $data = array();
            $data["salenum"] = $productBean["salenum"] + $productNum;
            $this->productModel->updateProductById($data, $productId);
            
        }
        
    }
    
    
    //TODO
    public function updateProdudctInventory($shopid,$productId,$productNum,$type,$detail){
        
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
        
        if($product['producttype'] == ProductType::FinishProduct || $product['producttype'] == ProductType::Material){
            return $this->updateMaterialInventory($shop['uniacid'],$shopid, $productId, $shop['defaultstoreid'], -$productNum,$type,$detail);
        }
        
        
        if($product['producttype'] == ProductType::SelfMadeProduct){
            
            $list = $this->productrelationModel->getRelationList($productId);
            foreach($list as $relation){
                $this->updateProdudctInventory($shopid, $relation['materialid'], $relation['num'], $type, $detail);
            }
            
        }
    }
    
    public function findInventoryBy($shopid,$productid,$storeid){
        $productInventory = $this->productInventoryModel->find($productid, $storeid);
        if(isset($productInventory)){
            return $productInventory;
        }
        
        //$productInventory['shopid'] = $shopid;
        $productInventory['productid'] = $productid;
        $productInventory['storeid'] = $storeid;
        $productInventory['inventory'] = 0;
        
        $this->productInventoryModel->addOne($productInventory);
        
        return $productInventory;
    }
    
    public function updateMaterialInventory($uniacid,$shopId,$materialId,$storeId,$num,$type = 1,$detail='',$userid = 0){
        
        $materialInventory = $this->findInventoryBy($shopId,$materialId, $storeId);
        
        $data = array();
        $data['inventory'] = $materialInventory['inventory'] + $num;
        $this->productInventoryModel->updateProductInventory($data, $materialId,$storeId);
        
        $logData = array();
        $logData['uniacid'] = $uniacid;
        $logData['shopid'] = $shopId;
        $logData['productid'] = $materialId;
        $logData['storeid'] = $storeId;
        $logData['num'] = $num;
        $logData['logtype'] = $type;
        $logData['createtime'] = time();
        $logData['detail'] = $detail;
        $logData['userid'] = $userid;
        $this->inventorylogModel->addLog($logData);
        
    }
    
    //进货
    public function inventoryStock($uniacid,$shopid,$productid,$inventory,$storeid,$userid,$stockid){
        $detail = "进货批次:".$stockid;
        $this->updateMaterialInventory($uniacid,$shopid,$productid,$storeid,$inventory, \common\OrderType::InventoryChangeStock,$detail,$userid);
    }
    
    //调货
    public function transferInventory($uniacid,$shopId,$productid,$inventory,$sourceid,$destinationid,$userid){
        $this->updateMaterialInventory($uniacid, $shopId, $productid, $sourceid, -$inventory, \common\OrderType::InventoryChangeTransferOut, "调拨出库", $userid);
        $this->updateMaterialInventory($uniacid, $shopId, $productid, $destinationid, $inventory, \common\OrderType::InventoryChangeTransferIn, "调拨入库", $userid);
    }
    
    //库存盘点
    public function inventoryCheck($uniacid,$shopid,$productid,$inventory,$storeId,$userid){
        
        $materialInventory = $this->findInventoryBy($shopid,$productid, $storeId);
        
        $data = array();
        $data['inventory'] = $inventory;
        $this->productInventoryModel->updateProductInventory($data, $productid,$storeId);
        
        $logData = array();
        $logData['uniacid'] = $uniacid;
        $logData['shopid'] = $shopid;
        $logData['productid'] = $productid;
        $logData['storeid'] = $storeId;
        $logData['num'] = $inventory -  $materialInventory['inventory'];
        $logData['logtype'] = \common\OrderType::InventoryChangeCheck;
        $logData['createtime'] = time();
        $logData['detail'] = "盘点,原来库存".$materialInventory['inventory']."调整为".$inventory;
        $logData['userid'] = $userid;
        $this->inventorylogModel->addLog($logData);
        
    }
    
    
    //报损
    public function inventoryDamage($uniacid,$shopid,$productid,$inventory,$storeid,$userid){
        $this->updateMaterialInventory($uniacid, $shopid, $productid, $storeid, -$inventory, \common\OrderType::InventoryChangeDamage, "库存报损", $userid);
    }
    
    //报溢
    public function inventoryFlow($uniacid,$shopid,$productid,$inventory,$storeid,$userid){
        $this->updateMaterialInventory($uniacid, $shopid, $productid, $storeid, $inventory, \common\OrderType::InventoryChangeFlow, "库存报溢", $userid);
    }
    
    
    
    
}
