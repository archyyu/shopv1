<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProduct
 *
 * @author YJP
 */
class ShopProduct extends Model{
    //put your code here
    
    protected $table = "shopv1_product";
    
    public function findProductByType($typeid){
        $list = $this->getList('*',['typeid'=>$typeid]);
        return $list;
    }
    
    public function findProductMapByUniacid($uniacid){
        $list = $this->getList("*",['uniacid'=>$uniacid]);
        $map = array();
        
        foreach($list as $key=>$value){
            $map[$value['id']] = $value;
        }
        
        return $map;
    }
    
    public function findProdudctById($productId){
        return $this->getOne("*",['id'=>$productId]);
    }
    
    public function findProductByUniacid($uniacid){
        return $this->getList("*",['uniacid'=>$uniacid]);
    }
    
    public function findProductByUniacidStore($uniacid,$storeid){
        return "";
    }
    
    
    public function addProduct($data){
        return $this->add($data);
    }
    
    public function updateProductById($data,$productId){
        return $this->save($data, ['id'=>$productId]);
    }
    
}
