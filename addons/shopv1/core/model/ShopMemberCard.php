<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopMemberCard
 *
 * @author YJP
 */
class ShopMemberCard extends Model{
    //put your code here
    
    protected $table = "shopv1_membercard";
    
    public function getMemberList($uid,$useflag = 0){
        
        $where = array();
        $where['memberid'] = $uid;
        $where["useflag"] = $useflag;
        $where["expiretime[>]"] = time();
        
        return $this->getList("*", $where);
    }
    
    
    public function addMemberCard($data){
        return $this->add($data);
    }
    
    public function getMemberCard($id){
        return $this->getOne("*",['id'=>$id,"useflag"=>0]);
    }
    
    public function useMemberCard($id){
        
        $data = array();
        $data["useflag"] = 1;
        $data["usetime"] = time();
        return $this->save($data, ['id'=>$id]);
    }
    
    public function saveMemberCard($data){
        $id = $data["id"];
        unset($data['id']);
        return $this->save($data,['id'=>$id]);
    }
    
    public function removeMemberCard($id){
        return $this->remove(['id'=>$id]);
    }
}
