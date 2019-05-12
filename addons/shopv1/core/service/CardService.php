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
    
    public function getMemberCardList($memberid){
        
        $list = $this->memberCardModel->getMemberList($memberid);
        return $list;
        
    }
    
    public function sendMemberCard($userid,$cardtypeid,$uid,$num = 1){
        
        $card = $this->cardTypeModel->getCard($cardtypeid);
        if(isset($card) == FALSE){
            return ;
        }
        
        for($i = 0;$i < num;$i++){
            
            $membercard = array();
            $membercard["cardtype"] = $cardtypeid;
            $membercard['senduserid'] = $userid;
            $membercard['memberid'] = $uid;
            $membercard['gettime'] = time();
            $membercard['cardname'] = $card['cardname'];
            $membercard['expiretime'] = $membercard['gettime'] + ($card['effectiveday']*24*60*60);
            $membercard['exchange'] = $card["exchange"];
            $membercard['discount'] = $card["discount"];
            $membercard['typeid'] = $card['typeid'];
            $membercard['productid'] = $card['productid'];
            
            $this->memberCardModel->addMemberCard($membercard);
            
        }
        
    }
    
    
}
