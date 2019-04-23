<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProductType
 *
 * @author YJP
 */
class ShopProductType extends Model{
    //put your code here
    protected $table = "shopv1_producttype";
    
    public function getProductTypeList($uniacid){
        $list = $this->getList("*",['uniacid'=>$uniacid,'visible'=>0]);
        return $list;
    }
    
    public function saveProductType($data){
        if(isset($data["id"])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data, ['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
    public function getProductTypeMap($uniacid){
        
        $list = $this->getList("*",['uniacid'=>$uniacid,'visible'=>0]);
        
        $map = array();
        foreach($list as $key=>$value){
            $map[$value['id']] = $value['typename'];
        }
        return $map;
    }
    
}
