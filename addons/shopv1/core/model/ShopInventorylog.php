<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopInventorylog
 *
 * @author YJP
 */
class ShopInventorylog extends Model{
    //put your code here
    protected $table = "shopv1_inventorylog";
    
    
    public function addLog($data){
        return $this->add($data);
    }
    
    public function getLogs($where){
        return $this->getList("*", $where);
    }
    
}
