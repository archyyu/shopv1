/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var Store={
    
    user : {},
    shop:{},
    
    createParams:function(){
        let params = {};
        params.shopid = Store.shop.id;// userInfo.shopid;
        params.userid = Store.user.id;// userInfo.id;
        params.from = 1;
        params.__uniacid = Store.shop.uniacid;
        return params;
    },
    
    initLoginInfo:function(msg){
        Store.shop = msg.shop;
        Store.user = msg.user;
    },
    
    info:function(){
        
    }
    
};