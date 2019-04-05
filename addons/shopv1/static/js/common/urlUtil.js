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
  }

};