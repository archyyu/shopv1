<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;


/**
 * Description of OrderController
 *
 * @author YJP
 */
class OrderController extends \controller\Controller{
    
    private $orderModel;
    
    private $storeModel;
    
    private $productModel;
    
    public function __construct() {
        parent::__construct();
        $this->storeModel = new \model\ShopStore();
        $this->orderModel = new \model\ShopOrder();
        $this->productModel = new \model\ShopProduct();

    }
    
    public function index(){
        $this->smarty->display('admin/waterbar/order.tpl');
    }
    
    public function loadOrders(){
        
        $uniacid = $this->getUniacid();
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");

        $shopid = $this->getParam("shopid");        
        $timearea = $this->getParam("timearea");
        $orderstate = $this->getParam("orderstate");
        $userid = $this->getParam("userid");

        $where['shopid'] = $shopid;
        $where['uniacid'] = $uniacid;
        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $where['createtime[<>]'] = [strtotime($timeArr[0] . " 00:00:00"), strtotime($starttime[1] . " 23:59:59")];
        }

        if ((int)$orderstate != 2) {
            $where['orderstate'] = $orderstate;
        }

        if ($userid) {
            $where['userid'] = $userid;
        }
        
//        $where["ORDER"] = ["createtime"=>"DESC"];
        
//        $storeMap = $this->storeModel->getStoreMapByUnacid($uniacid);
//        $productMap = $this->productModel->findProductMapByUniacid($uniacid);
        
        $list = $this->orderModel->page($offset, $limit, "*", $where, "createtime");
        
        // foreach($list["rows"] as $key=>$value){
            
            
            
        //     //$list['rows'][$key] = $value;
            
        // }
        
        $this->returnSuccess($list);
        
    }

    public function loadUsers(){

        $shopUserModel = new \model\ShopUser();
        $list = $shopUserModel->getUsers();
        $this->returnSuccess($list);
    }

    public function export()
    {
        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");        
        $timearea = $this->getParam("timearea");
        $orderstate = $this->getParam("orderstate");
        $userid = $this->getParam("userid");

        $where['shopid'] = $shopid;
        $where['uniacid'] = $uniacid;
        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $where['createtime[<>]'] = [strtotime($timeArr[0] . " 00:00:00"), strtotime($starttime[1] . " 23:59:59")];
        }

        if ((int)$orderstate != 2) {
            $where['orderstate'] = $orderstate;
        }

        if ($userid) {
            $where['userid'] = $userid;
        }
        
        $list = $this->orderModel->findOrders($where);

        
        $orderStateMap = array(
                '-1' => '未支付',
                '0' => '支付',
                '1' => '完成',
            );

        $orderSourceMap = array(
                '0' => '收银端',
                '1' => '手机端',
                '2' => '客户端',
            );

        $orderPaytypeMap = array(
                '0' => '现金',
                '1' => '微信',
                '2' => '支付宝',
            );

        /* 输入到CSV文件 */
        $html = "\xEF\xBB\xBF";

        /* 输出表头 */
        $filter = array(
            'id' => '订单号',
            'orderprice' => '订单金额',
            'createtime' => '订单时间',
            'paytype' => '支付方式',
            'ordersource' => '订单来源',
            'orderstate' => '订单状态',
            'address' => '地址',
            'orderdetail' => '订单详情'
        );

        foreach ($filter as $key => $title) {
            $html .= $title . "\t,";
        }
        $html .= "\n";

        foreach ($list as $k => $v) {
            $html .= $v['id'] . "\t, ";
            $html .= $v['orderprice'] . "\t, ";
            $html .= date('Y-m-d H:i:s', $v['createtime']) . "\t, ";
            $html .= $orderPaytypeMap[$v['paytype']] . "\t, ";
            $html .= $orderSourceMap[$v['ordersource']] . "\t, ";
            $html .= $orderStateMap[$v['orderstate']] . "\t, ";
            $html .= $v['address'] . "\t, ";
            $html .= $this->ConvertGBK($v['orderdetail']) . "\t, ";
            $html .= "\n";
        }


        /* 输出CSV文件 */
        header("Content-type:text/csv");
        header("Content-Disposition:attachment; filename=订单列表.csv");
        echo $html;
        exit();
    }
    
    private function ConvertGBK($data){
        $list = json_decode($data);
        if (count($list) > 0) {
            $detail = [];
            foreach ($list as $key => $value) {
                $detail[] = $value->productname . "|" . $value->num;
            }
            return implode(" ", $detail);
        }
        return "";
    }
}
