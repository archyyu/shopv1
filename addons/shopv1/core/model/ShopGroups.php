<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopGroups
 *
 * @author YJP
 */
class ShopGroups extends Model{
    
    protected $table = "mc_groups";
    
    public function getGroupsListByUniacid($uniacid){
        return $this->getList('*', ['uniacid'=>$uniacid]);
    }
    
}
