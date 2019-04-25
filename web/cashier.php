<?php
define('IN_SYS', true);
require '../framework/bootstrap.inc.php';
load()->web('common');
load()->web('template');
load()->func('file');
header('Content-Type: text/html; charset=UTF-8');
$uniacid = intval($_GPC['__uniacid']);
if (empty($uniacid)) 
{
	exit('Access Denied.');
}
$site = WeUtility::createModuleSite('shopv1');
$_GPC['c'] = 'site';
$_GPC['a'] = 'entry';
$_GPC['m'] = 'shopv1';

$_W['uniacid'] = (int) $_GPC['__uniacid'];
$_W['acid'] = (int) $_GPC['__uniacid'];
if (!(is_error($site))) 
{
	$method = "doCashier".$_GPC['do'];
	$site->uniacid = $uniacid;
	$site->inMobile = false;
	if (method_exists($site, $method)) 
	{
		$site->$method();
		exit();
	}
}
?>
