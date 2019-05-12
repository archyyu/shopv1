<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopMessage
 *
 * @author sophiabai
 */
class ShopMessage extends Model{
    
    protected $table = "shopv1_message";
    
    public function addMsg($data){
        $this->add($data);
    }
    
    
}
