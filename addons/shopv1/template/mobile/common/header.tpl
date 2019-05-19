<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale = 1">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title></title>
  <link rel="stylesheet" href="{$StaticRoot}/css/normalize.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/weui/weui.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/cube-ui/cube.min.css">
  <link rel="stylesheet" href="{$StaticRoot}/fonts/iconfont.css">
  <link rel="stylesheet" href="{$StaticRoot}/css/mobile/mobile.css">

  <script src="{$StaticRoot}/js/dist/vue.js"></script>
  {* <script src="https://unpkg.com/vue-router/dist/vue-router.js"></script> *}
  <script src="{$StaticRoot}/plugins/cube-ui/cube.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/axios.min.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/qs.js"></script>
  <script src="{$StaticRoot}/js/dist/axios/es6-promise.js"></script>
  <script src="{$StaticRoot}/fonts/iconfont.js"></script>
  <script src="{$StaticRoot}/js/dist/moment.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment-zh-cn.js"></script>
  <script src="{$StaticRoot}/js/dist/js.cookie.min.js"></script>

  <script>
  //axios.defaults.baseURL = ""
  axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
  axios.defaults.transformRequest = [function (data) {
    return Qs.stringify(data);
  }];


  var Loading = null;

  class LoadingType {
    static ToastLoading() {
      return {
        data: {
          hideMask: true
        }
      }
    };

    static hideLoading() {
      return {
        data: {
          hideLoading: true
        }
      }
    }
  }

  axios.interceptors.request.use(config => {
    var hideLoading = Boolean(Qs.parse(config.data).hideLoading);
    if (hideLoading) {
      return config;
    }

    var showToast = Boolean(Qs.parse(config.data).hideMask);
    Loading = app.$createToast({
      txt: '页面加载中...',
      time: 0,
      mask: !showToast
    });
    Loading.show();
    return config;
  }, (error) => {
    return Promise.reject(error);
  });
  // response interceptor
  axios.interceptors.response.use(res => {
    Loading.hide();
    return res
  }, (error) => {
    console.log('err');
    Loading.hide();
    app.$createToast({
      txt: '网络连接失败',
      type: 'error'
    }).show();
    return Promise.reject(error)
  });
  </script>
</head>
<body>
