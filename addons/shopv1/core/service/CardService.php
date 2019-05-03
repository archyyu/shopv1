<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace service;

use model\ShopCardtype;
use model\ShopMemberCard;

/**
 * Description of CardService
 *
 * @author YJP
 */
class CardService extends Service{
    
    private $cardTypeModel;
    
    private $memberCardModel;
    
    private $cardActivityModel;
    
    public function __construct() {
        parent::__construct();
        
        $this->cardTypeModel = new ShopCardtype();
        $this->memberCardModel = new ShopMemberCard();
        $this->cardActivityModel = new \model\ShopCardActivity();
        
    }
    
    public function memberGetCardFromActivity($activity,$uid,$userid){
        
        $activity["cardtype"];
        
        $activity["num"] += 1;
        
        
        
        $membercard = array();
        $membercard["cardtype"] = $activity["cardtype"];
        $membercard["activityid"] = $activity['id'];
        $membercard["userid"] = $userid;
        $membercard["uid"] = $uid;
        $membercard['gettime'] = time();
        
        $this->memberCardModel->addMemberCard($membercard);
        $this->cardActivityModel->updateActivity($activity);
        
    }
    
}
