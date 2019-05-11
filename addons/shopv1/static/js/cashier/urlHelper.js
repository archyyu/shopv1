/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var UrlHelper = {
    
    createUrl:function(d,f){
        return "cashier.php?__uniacid=1&f=" + f + "&do=" + d;
    },
    
    createFullUrl: function (f, d) {
        
        let url = window.location.href;
        let hrefreg = function (name) {
          return new RegExp("(&)" + name + "=([^&]*)(&|$)", "i");
        };
        let urlreg = function (name) {
          return new RegExp(name, "i");
        };
        if (d) {
          let oldDo = window.location.search.substr(1).match(hrefreg('do'));
          let doArr = oldDo[0].split("=");
          doArr[1] = d + "&";
          let newDo = doArr.join("=");
          url = url.replace(urlreg(oldDo[0]), newDo);
        }
        if (f) {
          let oldf = window.location.search.substr(1).match(hrefreg('f'))
          let fArr = oldf[0].split("=");
          fArr[1] = f + "&";
          let newf = fArr.join("=");
          url = url.replace(urlreg(oldf[0]), newf);
        }
        return url;
      },
    
    getWebBaseUrl:function(){
        let url = window.location.href.split("web")[0];
        return url;
    },

    getAppBaseUrl:function(){
        let url = window.location.href.split("app")[0];
        return url;
    },
    
    info:function(){
        
    }
    
};