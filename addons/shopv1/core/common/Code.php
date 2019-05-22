<?php
namespace common;

class Code {
    public static $success = ['state' => 0, 'msg' => '操作成功'];
    public static $error = ['state' => 1, 'msg' => '操作失败'];
    
    public static $query = ['state'=>2,"msg"=>'正在查询'];
    
    public static $err_potence = ['state' => 1001, 'msg' => '网吧名称不能为空'];
    public static $err_address = ['state' => 1002, 'msg' => '地址不能为空'];
    public static $err_pcnum = ['state' => 1003, 'msg' => '机器数量不能为空'];
    public static $err_principal = ['state' => 1004, 'msg' => '负责人不能为空'];
    public static $err_phone = ['state' => 1005, 'msg' => '电话不能为空'];
    public static $err_phone_format = ['state' => 1006, 'msg' => '手机号格式不正确'];
    public static $err_time = ['state' => 1007, 'msg' => '成立时间不能为空'];
    public static $err_gid = ['state' => 1008, 'msg' => 'gid不能为空'];
    public static $err_pcnum_format = ['state' => 1009, 'msg' => '机器数量只能是数字'];
    public static $err_type = ['state' => 1010, 'msg' => '请选择添加类型'];
    public static $err_pre = ['state' => 1011, 'msg' => '机器名前缀不能为空'];
    public static $err_name = ['state' => 1012, 'msg' => '机器名称不能为空'];
    public static $err_startName = ['state' => 1013, 'msg' => '开始机器号不能为空'];
    public static $err_endName = ['state' => 1013, 'msg' => '结束机器号不能为空'];
    public static $err_param = ['state' => 1014, 'msg' => '参数不能为空']; 
    
    public static function err($des){
        $result = array();
        $result['state'] = -1;
        $result['msg'] = $des;
        return $result;
    }
    
}