<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopFans
 *
 * @author YJP
 */
class ShopFans extends Model{
    protected $table = "mc_mapping_fans";

    public function findFanByUid($uid, $uniacid){
    	return $this->getOne("*", ["uid"=>$uid, "uniacid"=>$uniacid]);
    }

}
