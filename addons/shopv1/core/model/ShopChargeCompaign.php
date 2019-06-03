<?php


namespace model;


class ShopChargeCompaign extends Model{

    protected $table = "shopv1_charge_compaign";


    public function selectByUniacid($uniacid){
        return $this->getList("*",['uniacid'=>$uniacid]);
    }

    public function saveChargeCompaign($data){

        if(isset($data['id'])){
            $id = $data['id'];
            unset($data['id']);
            return $this->save($data,['id'=>$id]);
        }
        else{
            return $this->add($data);
        }

    }

}