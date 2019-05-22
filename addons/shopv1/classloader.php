<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


class ClassLoader{
    
    private static $includedList = array();
    
    public static function recurseInclude($dir){

        if(is_file($dir)){
            include($dir);
            ClassLoader::$includedList[$dir] = true;
        }
        else{
            $files = file_tree($dir);
            foreach($files as $file){
                if(is_dir($file)){
                    ClassLoader::recurseInclude($file);
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
                ClassLoader::recurseFindByClassName($file);
            }
            else{
                if(basename($file) == $className.".php"){
                    return $file;
                }
            }
        }
    }
 
    public static function includeFile($file){
        if(isset(ClassLoader::$includedList[$file]) == false){
            include($file);
            ClassLoader::$includedList[$file] = true;
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


ClassLoader::includeFile(CASHROOT."core/model/Medoo.php");
ClassLoader::includeFile(CASHROOT."core/service/Service.php");
ClassLoader::includeFile(CASHROOT."core/controller/Controller.php");

ClassLoader::recurseInclude(CASHROOT."core");

