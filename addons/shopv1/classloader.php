<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



function autoLoad($className){
    include (CASHROOT."core/".$className.".php");
}

spl_autoload_register('autoLoad');
