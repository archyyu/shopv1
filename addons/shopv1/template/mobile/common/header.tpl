<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale = 1">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>shopv1手机端</title>
  {* <link rel="stylesheet" href="{$StaticRoot}/css/normalize.css"> *}
  <link rel="stylesheet" href="{$StaticRoot}/plugins/cube-ui/cube.min.css">
  <link rel="stylesheet" href="{$StaticRoot}/fonts/iconfont.css">
  <link rel="stylesheet" href="{$StaticRoot}/css/mobile/mobile.css">

  <script src="{$StaticRoot}/js/dist/vue.js"></script>
  <script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
  <script src="{$StaticRoot}/plugins/cube-ui/cube.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/axios.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/qs.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/es6-promise.js"></script>
  <script src="{$StaticRoot}/fonts/iconfont.js"></script>
  <script src="{$StaticRoot}/js/dist/moment.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment-zh-cn.js"></script>

  <script>
    {* // Global Loading setting
    var loading = null;
    function startLoading (){
      loading = app.$createToast({
        mask: true,
        time:0,
        text: '页面加载中'
      });
      loading.show()
    }
    function stopLoading (){
      loading.hide();
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
    }); *}

    //axios.defaults.baseURL = ""
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    axios.defaults.transformRequest = [function (data) {
      return Qs.stringify(data);
    }];
  </script>
</head>
<body>
