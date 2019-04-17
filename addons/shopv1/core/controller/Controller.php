<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller;

use common\Code;

/**
 * Description of Controller
 *
 * @author Administrator
 */
class Controller {

    protected $smarty;

    protected $shopModel;

    function __construct() {

        $this->smarty = new \Smarty();
        $this->smarty->debugging = true;
        $this->smarty->caching = false;
        $this->smarty->cache_lifetime = 10;
        $this->smarty->assign("StaticRoot", StaticRoot);
        $this->smarty->setTemplateDir(CASHROOT . 'template/web');
        
        $this->shopModel = new \model\Shop();
        $this->initShopList();
    }
    
    public function initShopList(){
        $shopList = $this->shopModel->findShopListByUniacid($this->getUniacid());
        $this->smarty->assign("shopList", $shopList);
    }

    public function getParam($key) {
        global $_GPC;
        return $_GPC[$key];
    }

    public function getUniacid() {
        return $this->getParam("__uniacid");
    }  
    
    public function getUserid(){
        return 0;
    }

  /**
   * ajax返回
   * @param $params
   * @param int $json_option
   */
  public function ajaxReturn($params, $json_option = 0) {
    header('Content-Type:application/json; charset=utf-8');
    exit(json_encode($params, $json_option));
  }
  
  
  public function returnSuccess($obj = null){
      $arr = Code::$success;
      $arr['obj'] = $obj;
      $this->ajaxReturn($arr);
  }
  
  public function returnFail($msg,$obj=null){
      
      $arr = array();
      $arr["state"] = -1;
      $arr["msg"] = $msg;
      $arr['obj'] = $obj;
      
      $this->ajaxReturn($arr);
  }
 

    public function getUid() {
        return $this->getParam("__uid");
    }

    /**
     * 批量获取参数
     * @param array $params
     * @param string $method
     * @return array
     */
    public function getParams(array $params = [], $method = 'post') {
        if (!$params) {
            $method = strtolower($method);
            if ($method == 'post') {
                $data = $_POST;
            } else if ($method == 'get') {
                $data = $_GET;
            } else {
                $data = $_REQUEST;
            }
            foreach ($data as $k => $v) {
                $params[] = $k;
            }
        }
        foreach ($params as $paramKey => $paramVal) {
            $params[$paramVal] = is_array($this->getParam($paramVal)) ? json_encode($this->getParam($paramVal)) : trim($this->getParam($paramVal));

            unset($params[$paramKey]);
        }
        $params['uniacid'] = $this->getUniacid();
        return $params;
    }
}
