<?php


namespace controller\admin;


use controller\Controller;
use model\ShopChargeCompaign;

class ChargeController extends Controller{

	private $chargeCompaignModel;

	public function __construct(){
		parent::__construct();
		$this->chargeCompaignModel = new ShopChargeCompaign();
	}

	public function index(){
		$this->smarty->display("admin/chargeCompaign.tpl");
	}


	public function loadChargeCompaignList(){
		$uniacid = $this->getUniacid();

		$list = $this->chargeCompaignModel->selectByUniacid($uniacid);

		$this->returnSuccess($list);
	}

	public function saveData(){

		$id = $this->getParam("id");
		$chargefee = $this->getParam("chargefee");
		$awardfee = $this->getParam("awardfee");
		$uniacid = $this->getUniacid();

		$data = array();
		$data["id"] = $id;
		$data["chargefee"] = $chargefee;
		$data["awardfee"] = $awardfee;
		$data['uniacid'] = $uniacid;

		$result = $this->chargeCompaignModel->saveChargeCompaign($data);

		if($result){
			$this->returnSuccess();
		}
		else{
			$this->returnFail("保存错误");
		}

	}


}