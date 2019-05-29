<?php


namespace model;


class ShopMemberGroup extends Model {

    protected $table = "mc_groups";

    public function getMemberGroups($uniacd){

        return $this->getList("*",['uniacid'=>$uniacd]);

    }

    public function saveMemberGroup($data){

        if(isset($data['groupid'])){

            $groupid = $data['groupid'];
            unset($data['groupid']);
            return $this->save($data,["groupid"=>$groupid]);

        }
        else{
            $data['isdefault'] = 0;
            return $this->add($data);
        }

    }

}