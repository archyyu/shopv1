<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of index
 *
 * @author Administrator
 */

define('IN_IA',"1");

define("CASHROOT", str_replace("\\", "/", dirname(__FILE__)).'/');
define("StaticRoot","../shopv1/static");
//echo CASHROOT;

$_W = $_GPC = array();

include("../../data/config.php");

include('../../framework/function/file.func.php');
include('classloader.php');

$_W['config'] = $config;

class Router {
    
    public function __construct() {
        global $_GPC;
        global $_POST;
        $_GPC = array_merge($_GPC, $_POST);
        $_GPC = array_merge($_GPC, $_GET);
        
        
        
    }
    
    public function doIndex(){
        global $_GPC;
        $f = $_GPC['f'];
        
        if(isset($f) == false){
            $f = "index";
        }
        
        (new controller\cashier\ProductController())->$f();
        
    }
    
}

(new Router())->doIndex();
