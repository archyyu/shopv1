/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    special.queryRate();
})

$("#barSelect").change(function(){
    special.queryRate();
});

var special = {
    
    queryRate : function(){
        
        var gid = $("#barSelect").val();
        var parms = {};
        parms.gid = gid;
        
        var url = UrlUtil.createWebUrl("netbarinfo","special");
        
        $.post(url,parms,function(data){
            if(data.state == 0){
                $("#girlRate").val(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
            
        });
        
    },
    
    setRate : function(){
        var gid = $("#barSelect").val();
        
        var url = UrlUtil.createWebUrl("netbarinfo","special");
        var parms = {};
        parms.gid = gid;
        parms.rate = $("#girlRate").val();
        
        $.post(url,parms,function(data){
            if(data.state == 0){
                Tips.successTips("设置成功");
            }
            else{
                Tips.failTips("设置失败,原因:" + data.msg);
            }
        });
        
    },
    
    info : function(){
        
    }
    
};