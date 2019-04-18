<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProductLink
 *
 * @author YJP
 */
class ShopProductrelation extends Model{
    //put your code here
    protected $table = "shopv1_productrelation";
    
    public function getRelationList($productId){
        return $this->getList('*',['productid'=>$productId]);
    }
    
    public function deleteRelation($productid){
        return $this->remove(['productid'=>$productid]);
    }
    
    public function addRelation($productid,$materialid,$num){
        $data = array();
        
        $data['productid'] = $productid;
        $data['materialid'] = $materialid;
        $data['num'] = $num;
        
        return $this->add($data);
    }
    
    public function addNewRelation($data){
        return $this->add($data);
    }
    
}
