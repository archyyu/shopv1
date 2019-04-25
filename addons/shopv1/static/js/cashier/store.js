/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var Store = {
    
    token: '',
    shopInfo: {},
    userInfo: {},
    
    createParams:function(){
        let params = {};
        params.userid = Store.userInfo.id;
        params.from = 0;
        params.shopid = Store.userInfo.shopid;
        params.token = Store.token;
        params.__unacid = Store.shopInfo.uniacid;
        return params;
    },

    initLoginMsg: function(msg){
        Store.shopInfo = msg.shop;
        Store.userInfo = msg.user;
    },
    
    sourceToStr:function(source){
        if(source == 0){
            return "收银端";
        }
        else if(source == 1){
            return "手机端";
        }
        else if(source == 2){
            return "客户端";
        }
        return "未定义";
    },
    
    stateToStr:function(state){
        if(state == -1){
            return "未支付";
        }
        else if(state == 0){
            return "已支付";
        }
        else if(state == 1){
            return "已处理";
        }
        return "未定义";
    },
    
    info:function(){
        
    }
    
};