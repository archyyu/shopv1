<?php


namespace controller\admin;


use controller\Controller;
use model\ShopMessage;

class MessageController extends Controller
{

    private $messageModel;

    public function __construct()
    {
        parent::__construct();
        $this->messageModel = new ShopMessage();
    }

    public function index(){
        $this->smarty->display("admin/message.tpl");
    }

    public function getData(){

        $uniacid = $this->getUniacid();
        $shopid = $this->getParam("shopid");

        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");

        $where = array();
        $where["uniacid"] = $uniacid;
        $where["shopid"] = $shopid;

        $data = $this->messageModel->page($offset,$limit,"*",$where,"id");

        $this->returnSuccess($data);

    }

    public function changeState(){

        $messageid = $this->getParam("id");



    }

}