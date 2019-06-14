<?php


namespace controller\admin;


use controller\Controller;
use model\ShopCardtype;
use model\ShopChargeCompaign;

class ChargeController extends Controller{

	private $chargeCompaignModel;

	private $cardModel;

	public function __construct(){
		parent::__construct();
		$this->chargeCompaignModel = new ShopChargeCompaign();
		$this->cardModel = new ShopCardtype();
	}

	public function index(){
		$uniacid = $this->getUniacid();
		$cardlist = $this->cardModel->getCardTypeList($uniacid);

		$this->smarty->assign("cardlist",$cardlist);
		$this->smarty->display("admin/chargeCompaign.tpl");
	}


	public function loadChargeCompaignList(){
		$uniacid = $this->getUniacid();

		$list = $this->chargeCompaignModel->selectByUniacid($uniacid);

		$cardlist = $this->cardModel->getCardTypeList($uniacid);

		foreach($list as $key=>$value){

			if(isset($value['cardid'])){

				foreach($cardlist as $k=>$v){
					if($value["cardid"] == $v["id"]){

						$list[$key]["cardname"] = $v["cardname"];
						break;

					}
				}

			}

		}

		$this->returnSuccess($list);
	}

	public function saveData(){

		$id = $this->getParam("id");
		$chargefee = $this->getParam("chargefee");
		$awardfee = $this->getParam("awardfee");
		$cardid = $this->getParam("cardid");
		$cardnum = $this->getParam("cardnum");
		$credit1 = $this->getParam("credit1");
		$uniacid = $this->getUniacid();

		$data = array();
		$data["id"] = $id;
		$data["chargefee"] = $chargefee;
		$data["awardfee"] = $awardfee;
		$data['uniacid'] = $uniacid;
		$data['cardid'] = $cardid;
		$data['cardnum'] = $cardnum;
		$data['credit1'] = $credit1;

		$result = $this->chargeCompaignModel->saveChargeCompaign($data);

		if($result){
			$this->returnSuccess();
		}
		else{
			$this->returnFail("保存错误");
		}

	}


}