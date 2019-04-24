/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var Store = {
    
    token: '',
    gid: 0, 
    shopInfo: {},
    cashierInfo: {},
    
    createParams:function(){
        let params = {};
        params.userid = 1;
        params.from = 0;
        params.shopid = 1;
        return params;
    },

    initLoginMsg: function(msg){
        this.shopInfo = msg.first;
        this.cashierInfo = msg.second;
        this.gid = msg.first.gid;
        this.token = msg.second.token;
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