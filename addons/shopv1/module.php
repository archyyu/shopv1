<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

defined('IN_IA') or exit('Access Denied');

class Shopv1Module extends WeModule{
    
    public function welcomeDisplay()
	{
        //echo "asas";
		header('location: ' . './index.php?c=site&a=entry&m=shopv1&do=index');
		exit();
	}
    
}