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
  <link rel="stylesheet" href="{$StaticRoot}/css/cashier/cashier.css">

  <script src="{$StaticRoot}/js/dist/vue.js"></script>
  <script src="{$StaticRoot}/plugins/elementui/element-ui.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/axios.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/qs.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/es6-promise.js"></script>
  <script src="{$StaticRoot}/fonts/iconfont.js"></script>
  <script src="{$StaticRoot}/js/dist/moment.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment-zh-cn.js"></script>
  <script src="{$StaticRoot}/js/cashier/urlHelper.js"></script>

  <script>
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
    // request interceptor
    axios.interceptors.request.use(function(config){
      startLoading();
      return config;
    }, function(error){
      return Promise.reject(error);
    });
    // response interceptor
    axios.interceptors.response.use(function(res){
      stopLoading();
      return res;
    }, function(error){
      console.log('err');
      stopLoading();
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