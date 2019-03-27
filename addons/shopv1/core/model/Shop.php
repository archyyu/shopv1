<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of Shop
 *
 * @author YJP
 */
class Shop extends Model{
    
    protected $table = "shopv1_shop";
    
    public function findShopById($shopId){
        return $this->getOne("*",['id'=>$shopId]);
    }
    
}
