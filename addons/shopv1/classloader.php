<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

include('libs/smarty/Smarty.class.php');

include('core/model/Medoo.php');

$models = file_tree(CASHROOT.'core/model');
foreach($models as $modelPath){
    if(basename($modelPath) != "Medoo.php"){
        include ('core/model/'.basename($modelPath));
    }
}

$commons = file_tree(CASHROOT.'core/common');

foreach($commons as $commonsPath){
	include ('core/common/'.basename($commonsPath));
}

include('core/controller/Controller.php');

$controllers = file_tree(CASHROOT.'core/controller');
foreach($controllers as $controllerPath){
    if(basename($controllerPath)!="Controller.php"){
        include ('core/controller/'.basename($controllerPath));
    }
}

include('core/service/Service.php');

$services = file_tree(CASHROOT.'core/service');
foreach($services as $service){
    if(basename($service) != 'Service.php'){
        include('core/service/'. basename($service));
    }
}