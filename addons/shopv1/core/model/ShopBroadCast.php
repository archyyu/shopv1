<?php
/**
 * Created by IntelliJ IDEA.
 * User: YJP
 * Date: 2019/6/29
 * Time: 21:47
 */

namespace model;


class ShopBroadCast extends Model
{
    protected $table = "shopv1_broadcast";

    public function getBroadCastList($shopid){
        return $this->getList("*",["shopid"=>$shopid,"deleteflag"=>0]);
    }

    public function addBroadCast($data){
        return $this->add($data);
    }

    public function removeBroadCast($id){
        $data = array();
        $data["deleteflag"] = 1;
        return $this->save($data,["id"=>$id]);
    }

}