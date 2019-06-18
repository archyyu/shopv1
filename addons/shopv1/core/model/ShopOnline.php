<?php
/**
 * Created by IntelliJ IDEA.
 * User: YJP
 * Date: 2019/6/18
 * Time: 21:24
 */

namespace model;


class ShopOnline extends Model
{

    protected $table = "shopv1_online";

    public function addOnline($data){
        return $this->add($data);
    }

    public function addOnlineDetail($uniacid,$shopid,$uid,$idcard){

        $data = array();
        $data["uniacid"] = $uniacid;
        $data["shopid"] = $shopid;
        $data["uid"] = $uid;
        $data["idcard"] = $idcard;
        $data["time"] = time();

        return $this->addOnline($data);
    }

    public function addOnlineByMember($member,$shopid){

        return $this->addOnlineDetail($member["uniacid"],$shopid,$member["uid"],$member["idcard"]);

    }

}