<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopOrder
 *
 * @author YJP
 */
class ShopOrder extends Model{
    
    protected $table = "shopv1_order";
    
    public function addOrder($data){
        return $this->add($data);
    }
    
    public function saveOrder($data,$id){
         
        return $this->save($data,['id'=>$id]);
         
    }
    
    public function findOrderById($id){
        return $this->getOne("*", ['id'=>$id]);
    }
    
    public function findShopOrderList($shopid,$starttime,$endtime){
        return $this->getList("*", ['shopid'=>$shopid,'paytime[>=]'=>$starttime,'paytime[<=]'=>$endtime,'orderstate[>=]'=>0]);
    }
    
}
