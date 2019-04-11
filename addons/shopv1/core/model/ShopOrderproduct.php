<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopOrderproduct
 *
 * @author YJP
 */
class ShopOrderproduct extends Model{
    //put your code here
    protected $table = "shopv1_orderproduct";
    
    public function findOrderProductListByOrderId($orderid){
        return $this->getList("*",["orderid"=>$orderid]);
    }
    
    public function updateOrderProductList($data,$orderid){
        return $this->save($data, ["orderid"=>$orderid]);
    }
    
    public function addOrderProduct($data){
        return $this->add($data);
    }
    
}
