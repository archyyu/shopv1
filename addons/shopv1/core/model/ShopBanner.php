<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopBanner
 *
 * @author YJP
 */
class ShopBanner extends Model{
    
    protected $table = "shopv1_banner";
    
    public function getBannerList($shopid){
        return $this->getList("*", ['shopid'=>$shopid]);
    }
    
    public function addBanner($data){
        return $this->add($data);
    }
    
    public function removeBanner($id){
        return $this->remove(["id"=>$id]);
    }
    
}
