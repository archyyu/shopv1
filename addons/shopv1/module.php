<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

defined('IN_IA') or exit('Access Denied');

class CashModule extends WeModule{
    
    public function welcomeDisplay()
	{
		header('location: ' . './index.php?c=site&a=entry&m=cash&do=main&f=index');
		exit();
	}
    
}