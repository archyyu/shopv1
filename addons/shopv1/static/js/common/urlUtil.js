/**
 * Created by Administrator on 2019/3/15.
 */
var UrlUtil = {
  getQueryString: function (name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return decodeURI(r[2]);
    return null;
  },

  createWebUrl: function (doing, func) {
    return UrlUtil.createUrl(func,doing);
  },
  
  createShortUrl:function(f){
      return UrlUtil.createUrl(null,f);
  },
  
  createUrl: function (d, f) {
        
        let url = window.location.href;
        let hrefreg = function (name) {
          return new RegExp("(&)" + name + "=([^&]*)(&|$)", "i");
        };
        let urlreg = function (name) {
          return new RegExp(name, "i");
        };
        
        if (f) {
          let oldf = window.location.search.substr(1).match(hrefreg('f'));
          let fArr = oldf[0].split("=");
          fArr[1] = f + "&";
          let newf = fArr.join("=");
          url = url.replace(urlreg(oldf[0]), newf);
        }
        
        if (d) {
          let oldDo = window.location.search.substr(1).match(hrefreg('do'));
          let doArr = oldDo[0].split("=");
          doArr[1] = d + "&";
          let newDo = doArr.join("=");
          url = url.replace(urlreg(oldDo[0]), newDo);
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
  
  
  createWebUrlWithParams: function (controller, func, params) {
    var str = '';
    if (params) {
      $.each( params, function(key, val){
        if(val != 'undefined') {
          str += "&"+ key + "=" + val;
        }
      });
    }
    var url = "./index.php?c=site&a=entry&m=cash&do=" + controller + "&f=" + func + str;
    return url;
  }

};
var UrlHelper = UrlUtil;