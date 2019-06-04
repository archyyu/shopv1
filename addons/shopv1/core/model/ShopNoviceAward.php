<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopNoviceAward
 *
 * @author YJP
 */
class ShopNoviceAward extends Model{
    
    protected $table = "shopv1_noviceaward";
    
    public function findAwardByUniacid($uniacid){
        return $this->getOne("*", ['uniacid' => $uniacid, 'deleteflag' => 0]);
    }
    
    public function updateAward($data, $awardid){
    	return $this->save($data, ['id'=>$awardid]);
    }
    
    public function createAward($data){
    	return $this->add($data);
    }
}
