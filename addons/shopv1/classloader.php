<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

include('libs/smarty/Smarty.class.php');
 
class ClassLoader{
    
    private static $includedList = array();
    
    public static function recurseInclude($dir){

        if(is_file($dir)){
            include($dir);
            ClassLoader::$includedList[$file] = true;
        }
        else{
            $files = file_tree($dir);
            foreach($files as $file){
                if(is_dir($file)){
                    $this->recurseInclude($file);
                    continue;
                }
                else{
                    if(isset(ClassLoader::$includedList[$file]) == false){
                        include($file);
                        ClassLoader::$includedList[$file] = true;
                    }
                }
            }
        }
    }
    
    public static function recurseFindByClassName($dir,$className){
        $files = file_tree($dir);
        foreach($files as $file){
            if(is_dir($file)){
                $this->recurseFindByClassName($file);
            }
            else{
                if(basename($file) == $className.".php"){
                    return $file;
                }
            }
        }
    }
    
    public static function includeBaseClass($dir,$className){
        $file = ClassLoader::recurseFindByClassName($dir, $className);
        if(isset($file)){
            if(isset(ClassLoader::$includedList[$file]) == false){
                include($file);
                ClassLoader::$includedList[$file] = true;
            }
        }
    }
    
}

ClassLoader::includeBaseClass(CASHROOT."core", "Medoo");
ClassLoader::includeBaseClass(CASHROOT."core", "Service");
ClassLoader::includeBaseClass(CASHROOT."core", "Controller");

ClassLoader::recurseInclude(CASHROOT."core");

