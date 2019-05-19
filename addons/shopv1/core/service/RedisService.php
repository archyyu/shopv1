<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

/**
 * Description of RedisService
 *
 * @author sophiabai
 */
class RedisService extends Service{
    //put your code here

    private $redis;

    public function __construct() {
        parent::__construct();

        global $_W;
        $config = $_W['config']['setting']['redis'];

        $this->redis = new \Redis();
        $this->redis->connect($config['server'], $config['port']);

    }

    public function getMemberIdByTag($tag){
        return $this->redis->get("tag:".$tag);
    }
    
    public function clearMemberTag($tag){
        $this->redis->del("tag:".$tag);
        //$this->redis->delete("tag:".$tag);
    }

    public function setMemberid($tag,$memberid){
        return $this->redis->set("tag:".$tag,$memberid);
    }


    public function pushPrintMsg($order){

        $this->redis->lPush("print:".$order["shopid"], json_encode($order));

    }

    public function popPrintMsg($shopid){

        return $this->redis->rPop("print:".$shopid);

    }


    public function onlineTick(){

        return $this->redis->set("","");

    }

    public function queryOnlineList(){

        

    }


    public function pushNotify($shopid,$msg){

        $this->redis->lPush("notify:".$shopid, $msg);

    }

    public function popNotify($shopid){
        return $this->redis->rPop("notify:".$shopid);
    }

    public function setPhoneVerifyCode($phone,$code){
        $this->redis->set("phone:".$phone,$code);
    }

    public function getPhoneCode($phone){
        return $this->redis->get("phone:".$phone);
    }


}
