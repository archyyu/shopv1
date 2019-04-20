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

global $_GPC;
$_W = $_GPC = array();

include("../../data/config.php");

include('../../framework/function/file.func.php');
include('classloader.php');


$_GPC = array_merge($_GPC, $_POST);
$_GPC = array_merge($_GPC, $_GET);

$_W['config'] = $config;

class Router {
    
    public function __construct() {
        
    }
    
    public function product(){
        global $_GPC;
        $f = $_GPC['f'];
        
        if(isset($f) == false){
            $f = "index";
        }
        
        (new controller\cashier\ProductController())->$f();
        
    }
    
    public function order(){
        global $_GPC;
        $f = $_GPC['f'];
        
        (new controller\cashier\OrderController())->$f();
    }
    
   public function duty(){
       global $_GPC;
       $f = $_GPC['f'];
       
       (new controller\cashier\DutyController())->$f();
   }
   
    
}

$c = $_GPC['c'];

if(isset($c) == false){
    $c = "product";
}

(new Router())->$c();
