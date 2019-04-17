<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProductUnit
 *
 * @author YJP
 */
class ShopProductUnit extends Model{
    
    protected $table = "shopv1_product_unit";
    
    public function getProductUnitList($productid){
        return $this->getList("*",['productid'=>$productid]);
    }
    
    public function saveProductUnit($data){
        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data, ['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
    
}
