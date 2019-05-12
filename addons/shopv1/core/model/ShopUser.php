<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopUser
 *
 * @author YJP
 */
class ShopUser extends Model{
    //put your code here
    protected $table = "shopv1_user";
    
    public function getShopUserList($shopid){
        $list = $this->getList("*", ['shopid'=>$shopid]);
        return $list;
    }
    
    public function getShopUserById($userid){
        return $this->getOne("*",['id'=>$userid]);
    }
    
    public function getUserMap($uniacid){
        $list = $this->getList('*',['uniacid'=>$uniacid]);
        $map = array();
        foreach($list as $key=>$value){
            $map[$value['id']] = $value;
        }
        
        return $map;
    }
    
    public function getShop($account,$pwd){
        return $this->getOne("*", ['account'=>$account,"password"=>$pwd]);
    }
    
    public function saveUser($data){
        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data, ['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
    
    
}
