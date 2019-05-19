<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopStockOrder
 *
 * @author YJP
 */
class ShopStockOrder extends Model{
    
    protected $table = "shopv1_stock_order";
    
    public function addStockOrder($data){
    	if ($this->add($data)) {
    		return $data['lastInsertId'];
    	}
    	
        return 0;
    }
    
    
    
}
