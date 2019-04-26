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

    var url = "./index.php?c=site&a=entry&m=shopv1&do=" + doing + "&f=" + func;
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