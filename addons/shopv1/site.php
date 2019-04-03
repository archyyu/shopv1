<?php


define("CASHROOT", str_replace("\\", "/", dirname(__FILE__)).'/');
define("StaticRoot","../addons/cash/static");
include('classloader.php');

use controller\Controller;
use controller\IndexController;

class Shopv1ModuleSite extends WeModuleSite{
    
    public function __construct() {
        
    }

    public function getMenus(){
         
        $url = $this->getWebUrl();
        
        logInfo(" url:".$url);
        
        //return "memus";
        
        return array(
            array('title' => '管理后台', 'icon' => 'fa fa-shopping-cart', 'url' => $url)
            );
    }
    
    public function doWebIndex(){
        global $_GPC;
        
        ini_set('display_errors',1);
        
        $f = $_GPC['f'];
        
        //echo $f;
        $controller = new IndexController();
        $controller->$f();
       
        
    }
    
    public function doWebWeb(){
       // global $_GPC;
        try{
            logInfo("do web index");
            return "asas";
             
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doMobileMobile(){
        
    }
    
    public function payResult($params){
        
    }
    
    private function getWebUrl($do='',$query=array(),$full=true){
        
        global $_GPC;
        global $_W;
        
        $dos = explode('/',trim($do));
        $routes = array();
        $routes[] = $dos[0];
        
        if(isset($dos[1])){
            $routes[] = $dos[1];
        }
        
        if(isset($dos[2])){
            $routes[] = $dos[2];
        }
        
        if(isset($dos[3])){
            $routes[] = $dos[3];
        }
        
        $r = implode('.', $routes);
        
        if(!empty($r)){
            $query = array_merge(array('r'=>$r),$query);
        }
        
        $query = array_merge(array('do'=>'web'),$query);
        $query = array_merge(array('m'=>'shopv1'),$query);
        
        if($full){
            return $_W['siteroot'].'web/'.substr(wurl('site/entry', $query),2);
        }
        
        return wurl('site/entry',$query);
    }
}

