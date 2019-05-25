<?php


namespace service;


class SmsService extends Service{

    private $username;
    private $password;


    public function __construct(){
        parent::__construct();
        $this->username = "pinshang";
        $this->password = md5("123456");
    }

    public function sendContent($phone,$content){

        $content = urlencode($content);

        $url = "http://api.smsbao.com/sms?u=$this->username&p=$this->password&m=$phone&c=$content";
        $curl = curl_init();
        //设置抓取的url
        curl_setopt($curl, CURLOPT_URL, $url);
        //设置头文件的信息作为数据流输出
        curl_setopt($curl, CURLOPT_HEADER, 1);
        //设置获取的信息以文件流的形式返回，而不是直接输出。
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        //执行命令
        $data = curl_exec($curl);
        logInfo("send msg result:".$data);
        //关闭URL请求
        curl_close($curl);
        return $data;
    }



}