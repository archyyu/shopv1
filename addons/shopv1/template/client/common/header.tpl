<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>shopv1管理系统</title>
  <link rel="stylesheet" href="{$StaticRoot}/css/normalize.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/elementui/theme-chalk.css">
  <link rel="stylesheet" href="{$StaticRoot}/fonts/iconfont.css">
  <link rel="stylesheet" href="{$StaticRoot}/css/client/client.css">

  <script src="{$StaticRoot}/js/dist/vue.js"></script>
  <script src="{$StaticRoot}/plugins/elementui/element-ui.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/axios.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/qs.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/es6-promise.js"></script>
  <script src="{$StaticRoot}/js/dist/vue-lazyload.js"></script>
  <script src="{$StaticRoot}/fonts/iconfont.js"></script>
  <script src="{$StaticRoot}/js/dist/moment.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment-zh-cn.js"></script>
  <script src="{$StaticRoot}/js/common/urlUtil.js"></script>
  <script src="{$StaticRoot}/js/common/vue-qrcode.js"></script>

  <script src="{$StaticRoot}/js/common/dateUtil.js"></script>

  <script>
    Vue.component(VueQrcode.name, VueQrcode);
    Vue.use(VueLazyload);

    // Global Loading setting
    var loading = null;
    function startLoading (){
      loading = app.$loading({
        lock: true,
        text: '页面加载中',
        spinner: 'el-icon-loading',
        background: 'rgba(0, 0, 0, 0.7)'
      });
    }
    function stopLoading (){
      loading.close();
    }
    class LoadingType {
      static ToastLoading() {
        return {
          data: {
            hideMask: true
          }
        }
      };

      static fullLoading() {
        return {
          data: {
            fullLoading: true
          }
        }
      }
    }
    // request interceptor
    axios.interceptors.request.use(function(config){
      var showToast = Boolean(Qs.parse(config.data).hideMask);
      if(showToast){
        loading = app.$message({
          message: '页面加载中',
          center: true,
          iconClass: 'el-icon-loading',
          duration: 0
        });
      }
      var fullLoading = Boolean(Qs.parse(config.data).fullLoading);
      if(fullLoading){
        startLoading();
      }
      
      return config;
    }, function(error){
      return Promise.reject(error);
    });
    // response interceptor
    axios.interceptors.response.use(function(res){
      var showToast = Boolean(Qs.parse(res.config.data).hideMask);
      var fullLoading = Boolean(Qs.parse(res.config.data).fullLoading);
      if(showToast || fullLoading){
        stopLoading();
      }
      return res;
    }, function(error){
      console.log('err');
      if(loading){
        stopLoading();
      }
      
      app.$message.error('网络连接失败');
      return Promise.reject(error);
    });

    // axios.defaults.baseURL = ""
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    axios.defaults.transformRequest = [function (data) {
      return Qs.stringify(data);
    }];
  </script>
</head>
<body>