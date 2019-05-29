<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;
use service\CardService;
use service\WechatService;

/**
 * Description of MemberController
 *
 * @author YJP
 */
class MemberController extends \controller\Controller{
    
    private $memberModel;
    
    private $cardTypeModel;

    private $cardService;

    private $shopFansModel;

    private $shopGroupsModel;
    
    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
        $this->cardTypeModel = new \model\ShopCardtype();
        $this->shopFansModel = new \model\ShopFans();
        $this->shopGroupsModel = new \model\ShopGroups();
        $this->cardService = new CardService();
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }
    
    public function memberlist(){
        $uniacid = $this->getUniacid();
        $cardlist = $this->cardTypeModel->getCardTypeList($uniacid);
        $groupsList = $this->shopGroupsModel->getGroupsListByUniacid($uniacid);
        $this->smarty->assign("cardlist", $cardlist);
        $this->smarty->assign("groupsList", json_encode($groupsList));
        $this->smarty->assign("groups", $groupsList);
        $this->smarty->display("admin/member/memberList.tpl");
        
    }
    
    
    public function loadMembers(){
        $uniacid = $this->getUniacid();
        // $shopid = $this->getParam("shopid");
        $offset = $this->getParam("offset");
        $limit = $this->getParam("limit");

        $timearea = $this->getParam("timearea");
        $nickname = $this->getParam("nickname");
        $moblie = $this->getParam("moblie");
        $groupid = $this->getParam("groupid");

        $where = array();
        $where['uniacid'] = $uniacid;
        $timeArr = explode("-", $timearea);
        if (count($timeArr) == 2) {
            $where['createtime[<>]'] = [strtotime(trim($timeArr[0]). ":00"), strtotime(trim($timeArr[1]) . ":00")];
        }

        if ($nickname) {
            $where['nickname'] = $nickname;
        }

        if ($moblie) {
            $where['moblie'] = $moblie;
        }

        if ($groupid) {
            $where['groupid'] = $groupid;
        }
        // $where["shopid"] = $shopid;
        
        $list = $this->memberModel->page($offset, $limit, "*", $where, "createtime");
        
        $this->returnSuccess($list);
        
    }
    
    public function sendCard(){
        $uniacid = $this->getUniacid();
        $userid = $this->getUserid();
        $acid = $this->getAcid();
        $uid = $this->getParam("uid");
        $cardtypeid = $this->getParam("cardtypeid");
        $cardname = $this->getParam("cardname");
        $num = $this->getParam("num");

        $this->cardService->sendMemberCard($userid,$cardtypeid,$uid,$num);

        // $acc = WeAccount::create($acid);
        // $data = $acc->sendCustomNotice($send);
        // if(is_error($data)) {
        //     exit(json_encode(array('status' => 'error', 'message' => $data['message'])));
        // }

        $member = $this->shopFansModel->findFanByUid($uid, $uniacid);
        if ($member) {
            $content = "您收到卡券【" . $cardname . "】 * " . $num . "张";
            (new WechatService)->sendNotice($member['openid'], $content, $acid);
        }

        $this->returnSuccess();
    }
    
}
