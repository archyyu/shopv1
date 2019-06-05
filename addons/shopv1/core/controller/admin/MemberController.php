<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace controller\admin;
use model\ShopMemberClass;
use service\CardService;
use service\WechatService;

use model\ShopMemberGroup;

/**
 * Description of MemberController
 *
 * @author YJP
 */
class MemberController extends \controller\Controller{
    
    private $memberModel;

    private $memberGroupModel;

    private $cardTypeModel;

    private $cardService;

    private $shopFansModel;

    private $shopGroupsModel;

    private $shopClassModel;

    private $shopNoviceAwardModel;

    public function __construct() {
        parent::__construct();
        $this->memberModel = new \model\ShopMember();
        $this->memberGroupModel = new ShopMemberGroup();
        $this->cardTypeModel = new \model\ShopCardtype();
        $this->shopFansModel = new \model\ShopFans();
        $this->shopGroupsModel = new \model\ShopGroups();
        $this->shopClassModel = new ShopMemberClass();
        $this->cardService = new CardService();
        $this->shopNoviceAwardModel = new \model\ShopNoviceAward();
    }
    
    public function memberlevel(){
        $this->smarty->display("admin/member/memberLevel.tpl");
    }

    public function memberclass(){
        $this->smarty->display("admin/member/memberClass.tpl");
    }

    public function memberlist(){
        $uniacid = $this->getUniacid();
        $cardlist = $this->cardTypeModel->getCardTypeList($uniacid);
        $groupsList = $this->shopGroupsModel->getGroupsListByUniacid($uniacid);
        $classs = $this->shopClassModel->selectClassByUniacid($uniacid);
        $this->smarty->assign("cardlist", $cardlist);
        $this->smarty->assign("groupsList", json_encode($groupsList));
        $this->smarty->assign("groups", $groupsList);
        $this->smarty->assign("classs",$classs);
        $this->smarty->display("admin/member/memberList.tpl");

    }
    
    public function newmember(){
        $uniacid = $this->getUniacid();
        $award = $this->shopNoviceAwardModel->findAwardByUniacid($uniacid);
        $cardlist = $this->cardTypeModel->getCardTypeList($uniacid);
        if (!$award) {
            $data['points'] = 0;
            $data['cardtypeid'] = 0;
            $data['uniacid'] = $uniacid;
            $result = $this->shopNoviceAwardModel->createAward($data);
            if ($result) {
                $award = $this->shopNoviceAwardModel->findAwardByUniacid($uniacid);
            }
        }
        $this->smarty->assign("cardlist", $cardlist);
        $this->smarty->assign("award", $award);
        $this->smarty->display("admin/member/newmember.tpl");
    }

    public function saveNoviceAward(){
        $uniacid = $this->getUniacid();
        $field = $this->getParam("field");
        $val = $this->getParam("val");
        $awardid = $this->getParam("awardid");

        $data[$field] = $val;

        $result = $this->shopNoviceAwardModel->updateAward($data, $awardid);
        if ($result) {
            return $this->returnSuccess();
        }
        return $this->returnFail("保存失败");
        
    }

    public function loadMemberClass(){
        $uniacid = $this->getUniacid();
        $list = $this->shopClassModel->selectClassByUniacid($uniacid);
        $this->returnSuccess($list);
    }

    public function saveMemberClass(){

        $classid = $this->getParam("classid");
        $uniacid = $this->getUniacid();
        $title = $this->getParam("title");

        $data = array();
        $data['classid'] = $classid;
        $data['uniacid'] = $uniacid;
        $data['title'] = $title;

        $result = $this->shopClassModel->saveClass($data);
        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("error");
        }

    }

    public function loadMemberGroups(){

        $uniacid = $this->getUniacid();
        $list = $this->memberGroupModel->getMemberGroups($uniacid);
        $this->returnSuccess($list);

    }

    public function saveMemberGroup(){

        $uniacid = $this->getUniacid();
        $groupid = $this->getParam("groupid");
        $title = $this->getParam("title");
        $credit = $this->getParam("credit");

        $data = array();

        if($groupid != "") {
            $data['groupid'] = $groupid;
        }

        $data['uniacid'] = $uniacid;
        $data["title"] = $title;
        $data['credit'] = $credit;

        $result = $this->memberGroupModel->saveMemberGroup($data);

        if($result){
            $this->returnSuccess();
        }
        else{
            $this->returnFail("保存失败");
        }

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
    
    public function sendCards(){
        $uniacid = $this->getUniacid();
        $userid = $this->getUserid();
        $acid = $this->getAcid();
        $uids = $this->getParam("uids");
        $cardtypeid = $this->getParam("cardtypeid");
        $cardname = $this->getParam("cardname");
        $num = $this->getParam("num");

        $uidArr = explode(',', $uids);

        if (count($uidArr) > 0) {
            foreach ($uidArr as $key => $uid) {
                
                $this->cardService->sendMemberCard($userid,$cardtypeid,$uid,$num);

                $member = $this->shopFansModel->findFanByUid($uid, $uniacid);
                if ($member) {
                    $content = "您收到卡券【" . $cardname . "】 * " . $num . "张";
                    (new WechatService)->sendNotice($member['openid'], $content, $acid);
                }
            }
        }

        $this->returnSuccess();
    }
}
