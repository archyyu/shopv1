<?php


namespace service;


use model\ShopFans;

class WechatService extends Service{

    private $shopFans;

    public function __construct(){
        parent::__construct();
        $this->shopFans = new ShopFans();
    }

    public function sendNoticeByUid($uid,$content,$acid){

        $member = $this->shopFans->findFanByUid($uid, $acid);
        $this->sendNotice($member["openid"],$content,$acid);
    }

    public function sendNotice($openid, $content, $acid){

        try {
            
                $token = $this->getAccessToken($acid);
                if(!$token){
                    logInfo("TOKEN获取失败");
                    return;
                }

                $data = array(
                    'touser' => $openid,
                    'msgtype' => 'text',
                    'text' => array(
                        'content' => $content
                    )

                );

                $this->sendCustomNotice($data, $token);

                // foreach ($openids as $openid) {
                    
                // }
                
        } catch (Exception $e) {
            logError("发送微信消息异常", $e);
        }

    }

    private function getAccessToken($acid) {
        $cachekey = cache_system_key('accesstoken', array('acid' => $acid));
        $cache = cache_load($cachekey);
        if (!empty($cache) && !empty($cache['token']) && $cache['expire'] > TIMESTAMP) {
            $this->account['access_token'] = $cache;
            return $cache['token'];
        }

        $accounts = pdo_fetchall("SELECT `key`, `secret`, `acid` FROM ".tablename('account_wechats')." WHERE uniacid = :uniacid ORDER BY `level` DESC ", array(':uniacid' => $GLOBALS['_W']['uniacid']));
        if (empty($accounts)) {
            logInfo("no permission, uniacid=" . $GLOBALS['_W']['uniacid']);
            return "";
        }
        foreach ($accounts as $account) {
            if (empty($account['key']) || empty($account['secret'])) {
                continue;
            }
            
            $url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$account['key']}&secret={$account['secret']}";
            $content = ihttp_get($url);
            if(is_error($content)) {
                logInfo('获取微信公众号授权失败, 请稍后重试！错误详情: ' . $content['message']);
                return "";
            }

            if (empty($content['content'])) {
                logInfo('AccessToken获取失败，请检查appid和appsecret的值是否与微信公众平台一致！');
                return "";
            }

            $token = @json_decode($content['content'], true);
            if(empty($token) || !is_array($token) || empty($token['access_token']) || empty($token['expires_in'])) {
                $errorinfo = substr($content['meta'], strpos($content['meta'], '{'));
                $errorinfo = @json_decode($errorinfo, true);
                logInfo('获取微信公众号授权失败, 请稍后重试！ 公众平台返回原始数据为: 错误代码-' . $errorinfo['errcode'] . '，错误信息-' . $errorinfo['errmsg']);
                return "";
            }

            $record = array();
            $record['token'] = $token['access_token'];
            $record['expire'] = TIMESTAMP + $token['expires_in'] - 200;
            cache_write($cachekey, $record);
            return $record['token'];
        }

        return "";
    }

    private function sendCustomNotice($data, $token) {
        if(empty($data)) {
            logInfo('参数错误');
            return;
        }
        // $token = $this->getAccessToken();
        // if(!$token){
        //     logInfo("TOKEN获取失败");
        //     return;
        // }
        $url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token={$token}";
        $response = ihttp_request($url, urldecode(json_encode($data, JSON_UNESCAPED_UNICODE)));
        if(is_error($response)) {
            logInfo("访问公众平台接口失败, 错误: {$response['message']}");
            return;
        }
        $result = @json_decode($response['content'], true);
        if(empty($result)) {
            logInfo("接口调用失败, 元数据: {$response['meta']}");
            return;
        } elseif(!empty($result['errcode'])) {
            logInfo("访问微信接口错误, 错误代码: {$result['errcode']}, 错误信息: {$result['errmsg']},错误详情：{$result['errcode']}");
            return;
        }
        return;
    }


}