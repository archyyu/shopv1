<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopMemberTag
 *
 * @author YJP
 */
class ShopMemberTag extends Model{
    
    protected $table = "shopv1_tags";
    
    //columns; id memberid uniacid tag deleteflag tagtype
    //tagtype:0  tagtype:12345678910
    
    public function addMemberTag($data){
        return $this->add($data);
    }
    
    public function removeMemberTag($id){
        return $this->remove(['id'=>$id]);
    }
    
    public function getMemberTaglist($uid){
        return $this->getList("*", ['memberid'=>$uid]);
    }
    
    
    
}
