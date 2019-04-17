<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProductInventory
 *
 * @author YJP
 */
class ShopProductInventory extends Model{
    //put your code here
    protected $table = "shopv1_productinventory";
    
    public function find($productid,$storeid){
        return $this->getOne("*",['productid'=>$productid,'storeid'=>$storeid]);
    }
    
    public function updateProductInventory($data,$productid,$storeid){
        return $this->save($data, ['productid'=>$productid,'storeid'=>$storeid]);
    }
    
    public function addOne($data){
        return $this->add($data);
    }
    
}
