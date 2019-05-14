<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of WechatAccount
 *
 * @author YJP
 */
class WechatAccount extends Model{
    //put your code here
    
    protected $table = "uni_account";
    
    public function findWechatAccountByUniacid($uniacid){
        return $this->getOne("*", ["uniacid"=>$uniacid]);
    }
    
    
}
