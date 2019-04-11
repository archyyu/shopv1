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
    
    public function saveOrder($data){
        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data,['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
    public function findOrderById($id){
        return $this->getOne("*", ['id'=>$id]);
    }
    
}
