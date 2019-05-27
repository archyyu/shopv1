<?php


define("CASHROOT", str_replace("\\", "/", dirname(__FILE__)).'/');
define("StaticRoot","../addons/shopv1/static");
include('classloader.php');

use controller\IndexController;

class Shopv1ModuleSite extends WeModuleSite{
    
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
        logInfo("do web index");
        try{
            $f = $_GPC['f'];
            //echo $f;
            $controller = new IndexController();
            $controller->$f();
        }
        catch (Exception $ex){
            logError("err", $ex);
        }
    }
    
    public function doWebProduct(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new controller\admin\ProductController();
            $controller->$f();
        }
        catch (Exception $ex){
            logError('er',$ex);
        }
    }
    
    public function doWebShop(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new \controller\admin\ShopController();
            $controller->$f();
        }
        catch(Exception $ex){
            logError('err', $ex);
        }
    }
    
    public function doWebOrder(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new controller\admin\OrderController();
            $controller->$f();
        }
        catch (Exception $ex){
            logError("err", $ex);
        }
    }

    public function doWebMessage(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new \controller\admin\MessageController();
            $controller->$f();
        }
        catch(Exception $ex){
            logError("err",$ex);
        }
    }
    
    public function doWebDuty(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new controller\admin\DutyController();
            $controller->$f();
        }
        catch (Exception $ex){
            logError("err",$ex);
        }
    }
    
    public function doWebCard(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new controller\admin\CardController();
            $controller->$f();
        }
        catch (Exception $ex){
            logError("err", $ex);
        }
    }
    
    
    public function doWebWaterbar(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new \controller\WaterbarController();
            $controller->$f();
        }
        catch(Exception $ex){
            logError('err', $ex);
        }
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
    
    public function doCashierduty(){
        global $_GPC;
        try{
            $dutyController = new controller\cashier\DutyController();
            $f = $_GPC['f'];
            $dutyController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doCashierorder(){
        global $_GPC;
        try{
            $orderController = new controller\cashier\OrderController();
            $f = $_GPC['f'];
            $orderController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doCashierproduct(){
        global $_GPC;
        try{
            $productController = new controller\cashier\ProductController();
            $f = $_GPC['f'];
            $productController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doCashiermember(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $memberController = new controller\cashier\MemberController();
            $memberController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
        
    }
    
    public function doCashieruser(){
        global $_GPC;
        try{
            $userController = new controller\cashier\UserController();
            $f = $_GPC['f'];
            $userController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    //
    //$_W["openid"]
    //$_W["member"]
    // ["uid"]=> string(1) "1" ["realname"]=> string(0) "" ["mobile"]=> string(11) "18633919531" ["email"]=> string(0) "" ["groupid"]=> string(1) "2" ["credit1"]=> string(4) "0.00" ["credit2"]=> string(4) "0.00" ["credit6"]=> string(4) "0.00" ["groupname"]=> string(15) "默认会员组"
    //
    public function doMobileMobile(){
        mc_oauth_userinfo();
        
        global $_GPC;
        try{
            $mobileController = new \controller\mobile\MobileController;
            $f = $_GPC['f'];
            $mobileController->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
        
    }
    
    public function doMobileProduct(){
        global $_GPC;
        try{
            $controller = new \controller\cashier\ProductController();
            $f = $_GPC['f'];
            $controller->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
    }
    
    public function doMobileOrder(){
        global $_GPC;
        try{
            $f = $_GPC['f'];
            $controller = new \controller\cashier\OrderController();
            $controller->$f();
        }
        catch (Exception $ex){
            logInfo("ex:".$ex->getMessage());
        }
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

