<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopCardtype
 *
 * @author YJP
 */
class ShopCardtype extends Model{
    //put your code here
    protected $table = "shopv1_cardtype";
    
    public function getCardTypeList($uniacid){
        $list = $this->getList("*", ['uniacid'=>$uniacid,'deleteflag'=>0]);
        return $list;
    }
    
    public function saveCardType($data){
        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data,['id'=>$id]);
        }
        else{
            return $this->add($data);
        }
    }
    
    public function getCard($id){
        
        return $this->getOne("*", ['id'=>$id]);
        
    }
    
}
