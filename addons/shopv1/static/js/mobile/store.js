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
        params.shopid = 1;//Store.shop.id;// userInfo.shopid;
        params.userid = 1;//Store.user.id;// userInfo.id;
        params.from = 1;
        params.__uniacid = 1;//Store.shop.uniacid;
        return params;
    },
    
    initLoginInfo:function(msg){
        Store.shop = msg.shop;
        Store.user = msg.user;
    },
    
    paytypeStr:function(type){
        if(type == 0){
            return "现金";
        }
        else if(type==1){
            return "微信";
        }
        else if(type == 2){
            return "支付宝";
        }
    },
    
    ordersourceStr:function(source){
        if(source == 0){
            return "收银端";
        }
        else if(source == 1){
            return "手机端";
        }
        else if(source == 2){
            return "客户端";
        }
    },
    
    info:function(){
        
    }
    
};