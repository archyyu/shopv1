<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopStore
 *
 * @author YJP
 */
class ShopStore extends Model{
    //put your code here
    
    protected $table = "shopv1_store";
    
    public function getStoreListByUniacid($uniacid){
        return $this->getList('*', ['uniacid'=>$uniacid]);
    }
    
    public function getStoreListByShopid($shopid){
        return $this->getList("*",["shopid"=>$shopid]);
    }
    
    public function getStoreMapByUnacid($uniacid){
        $list = $this->getList("*",['uniacid'=>$uniacid]);
        
        $map = array();
        foreach($list as $key=>$value){
            $map[$value['id']] = $value;
        }
        
        return $map;
    }
    
    public function addStore($name,$shopid,$uniacid){
        
        $data = array();
        $data["storename"] = $name;
        $data['shopid'] = $shopid;
        $data['uniacid'] = $uniacid;
        $data['createdate'] = date("Y-m-d H:i:s");
        
        $this->add($data);
        return $data["lastInsertId"];
    }
    
    public function saveStore($data){
        
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
