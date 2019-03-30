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
define("StaticRoot","../cash/static");
//echo CASHROOT;

$_W = $_GPC = array();

include("../../data/config.php");

include('../../framework/function/file.func.php');
include('classloader.php');

$_W['config'] = $config;

class Router {
    
    public function __construct() {
        global $_GPC;
        $_GPC = array_merge($_GPC, $_POST);
        $_GPC = array_merge($_GPC, $_GET);
        
    }
    
    public function doIndex(){
        global $_GPC;
        echo $_GPC["haha"];
        
        (new controller\NetbarMemberController())->index();
        
    }
    
};

(new Router())->doIndex();
