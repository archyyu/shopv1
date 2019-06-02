<?php


namespace model;


class ShopMemberClass extends Model{

    protected $table = "mc_class";


    public function selectClassByUniacid($uniacid){

        return $this->getList("*",['uniacid'=>$uniacid]);

    }


    public function saveClass($data){

        if(isset($data['classid'])){
            $classid = $data['classid'];
            unset($data['classid']);
            return $this->save($data,['classid'=>$classid]);
        }
        else{
            return $this->add($data);
        }

    }

}