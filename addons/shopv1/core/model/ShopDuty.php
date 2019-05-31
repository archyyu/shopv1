<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopShift
 *
 * @author YJP
 */
class ShopDuty extends Model{
    //put your code here
    protected $table = "shopv1_duty";
    
    public function saveDuty($data){
        return $this->add($data);
    }

    public function selectDutyById($dutyId){
        return $this->getOne("*",['dutyid'=>$dutyId]);
    }
    
    public function selectShopLastDuty($shopid){
        $duty = $this->getOne("*", ['shopid'=>$shopid,'ORDER'=>['id'=>'DESC'],'LIMIT'=>1]);
        return $duty;
    }
    
    
    
}
