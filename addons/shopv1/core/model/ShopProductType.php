<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace model;

/**
 * Description of ShopProductType
 *
 * @author YJP
 */
class ShopProductType extends Model{
    //put your code here
    protected $table = "shopv1_producttype";
    
    public function getProductTypeList($uniacid){
        $list = $this->getList("*",['uniacid'=>$uniacid,'visible'=>0]);
        return $list;
    }
    
    
    
}
