<?php


define("CASHROOT", str_replace("\\", "/", dirname(__FILE__)).'/');

include('classloader.php');



class CashModuleSite extends WeModuleSite{
    
    public function __construct() {
        
    }

    public function getMenus(){
        global $_W;
        
        $url = $this->getWebUrl();
        
        logInfo(" url:".$url);
        
        return array(
            array('title' => '管理后台', 'icon' => 'fa fa-shopping-cart', 'url' => $url)
            );
    }
    
    
    
    public function doWebMain(){
        global $_GPC;
        try{
            $func = $_GPC['f'];
            
            $controller = new MainController();
            $controller->$func();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doMobileMobile(){
        
    }
    
    public function payResult($params){
        
    }
    
    
}

?>