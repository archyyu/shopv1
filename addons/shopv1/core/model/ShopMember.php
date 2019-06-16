<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopMember
 *
 * @author YJP
 */
class ShopMember extends Model{
    
    protected $table = "mc_members";
    
    public function queryMemberList($where){
        return $this->getList("*", $where);
    }
    
    public function saveMember($data,$uid){
        return $this->save($data, ["uid"=>$uid]);
    }
    
    public function queryMemberByUid($uid){
        return $this->getOne("*", ['uid'=>$uid]);
    }

    public function queryMemberByIdcard($idcard){
        return $this->getOne("*",["idcard"=>$idcard]);
    }

    public function queryOneMember($where){
        return $this->getOne("*",$where);
    }
    
    public function quertyMember($uniacid,$phone){
        
        $where = array();
        $where['uniacid'] = $uniacid;
        $where['mobile'] = $phone;
        
        return $this->getOne("*",$where);
    }
    
    
}
