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
    
    
    
    public function findShopListByUniacid($uniacid){
        return $this->getList("*",['uniacid'=>$uniacid]);
    }
    
    public function findShopMapByUnacid($uniacid){
        $list = $this->getList("*",['uniacid'=>$uniacid]);
        
        $map = array();
        foreach($list as $key=>$value){
            $map[$value['id']] = $value;
        }
        return $map;
        
    }
    
    public function saveShop($data){
        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data,['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
}
