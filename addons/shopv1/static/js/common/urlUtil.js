/**
 * Created by Administrator on 2019/3/15.
 */
var UrlUtil = {
  getQueryString: function (name,route) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    if (!route) {
      var r = window.location.search.substr(1).match(reg);
  } else {
      var r = route.match(reg);
  }
    if (r != null) return decodeURI(r[2]);
    return null;
  },

  createWebUrl: function (func, doing) {
    return UrlUtil.createUrl(func,doing);
  },
  
  createShortUrl:function(f){
      return UrlUtil.createUrl(null,f);
  },
  
  createUrl: function (d, f) {
        let location = window.location;
        let searchStr = window.location.search;
        let hrefreg = function (name) {
          return new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        };
        let urlreg = function (name) {
          return new RegExp(name, "i");
        };
        
        if (f) {
          let oldf = location.search.substr(1).match(hrefreg('f'));
          let fArr = oldf[0].split("=");
          fArr[1] = fArr[1].indexOf("&")<0?f:f + "&";
          let newf = fArr.join("=");
          searchStr = searchStr.replace(urlreg(oldf[0]), newf);
        }
        
        if (d) {
          let oldDo = location.search.substr(1).match(hrefreg('do'));
          let doArr = oldDo[0].split("=");
          doArr[1] = doArr[1].indexOf("&")<0?d:d + "&";
          let newDo = doArr.join("=");
          searchStr = searchStr.replace(urlreg(oldDo[0]), newDo);
        }
        return location.origin + location.pathname + searchStr;
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