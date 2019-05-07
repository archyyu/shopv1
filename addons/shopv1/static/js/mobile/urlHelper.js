/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var UrlHelper = {
    
    createUrl:function(d,f){
        return "cashier.php?__uniacid=1&f=" + f + "&do=" + d;
    },
    
    getAppBaseUrl:function(){
      let url = window.location.href.split("app")[0];
      return url;
    },
    
    getWebBaseUrl:function(){
      let url = window.location.href.split("web")[0];
      return url;
  },
    
    info:function(){
        
    }
    
};