<?php
namespace common;
/**
 * @file Controller.class.php
 * @brief 公共类
 * @author wangxuying
 * @date 2017-02-10
 */
class Common {
    /**
     * 判断是否是手机号
     *
     * @param $mobile
     * @return int
     */
    public static function isMobile($mobile) {
        return preg_match('/^1[3456789]\d{9}$/', $mobile);
    }

    /**
     * 校验邮箱
     * @param $email
     * @return false|int
     */
    public static function isEmail($email) {
        $reg = '/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/';
        return preg_match($reg, trim($email));
    }

    /**
     * 去除各种空格换行符等
     * @param $str
     * @return mixed
     */
    public static function trimAll($str) {
        $qian = array(" ", "　", "\t", "\n", "\r");
        return str_replace($qian, '', $str);
    }

    /**
     * 校验身份证
     * @param $card
     * @return false|int
     */
    public static function isIdCard($card) {
        $reg = '/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/';
        return preg_match($reg, self::trimAll($card));

    }

    /**
     * ajax返回
     * @param array $params
     */
    public static function ajaxReturn(array $params) {
        echo json_encode($params);
        die;
    }
}