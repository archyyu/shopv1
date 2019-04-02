<!DOCTYPE html>
<html lang="zh-CN">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>shopv1管理系统</title>
  <link rel="stylesheet" href="{$StaticRoot}/bootstrap-3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/bootstrap-table/bootstrap-table.min.css">
  <link rel="stylesheet" href="{$StaticRoot}/css/animate.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/noty/noty.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/noty/themes/metroui.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/metismenu/metisMenu.min.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/daterangepicker/daterangepicker.css">
  <link rel="stylesheet" href="{$StaticRoot}/plugins/bootstrap-select/css/bootstrap-select.css">
  <link rel="stylesheet" href="{$StaticRoot}/fonts/iconfont.css">
  <link rel="stylesheet" href="{$StaticRoot}/css/common.css">

  <script src="{$StaticRoot}/js/dist/jsmart.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment.min.js"></script>
  <script src="{$StaticRoot}/js/dist/moment-zh-cn.js"></script>
  <script src="{$StaticRoot}/js/dist/jquery/jquery-1.11.1.min.js"></script>
  <script src="{$StaticRoot}/js/dist/jquery.nicescroll.min.js"></script>
  <script src="{$StaticRoot}/plugins/metismenu/metisMenu.min.js"></script>
  <script src="{$StaticRoot}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
  <script src="{$StaticRoot}/js/dist/bootbox/bootbox.all.min.js"></script>
  <script src="{$StaticRoot}/plugins/bootstrap-select/js/bootstrap-select.min.js"></script>
  <script src="{$StaticRoot}/plugins/bootstrap-select/js/i18n/defaults-zh_CN.min.js"></script>
  <script src="{$StaticRoot}/plugins/bootstrap-table/bootstrap-table.min.js"></script>
  <script src="{$StaticRoot}/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
  <script src="{$StaticRoot}/plugins/noty/noty.min.js"></script>
  <script src="{$StaticRoot}/plugins/daterangepicker/daterangepicker.js"></script>

  
  <script src="{$StaticRoot}/js/common/urlUtil.js" ></script>
  <script src="{$StaticRoot}/js/common/tipsUtil.js" ></script>

  <!-- 数据模拟js，生产环境不需要 -->
  <script src="{$StaticRoot}/js/dist/mock.js"></script>
  <script src="{$StaticRoot}/js/web/mockData.js"></script>
    {literal}
    <script>
      $(function () {
        
        // scroll init
        $(".left-menu-wrapper").niceScroll();
        $("#leftMenu li").on('click',function(){
          console.log("li")
          $(".left-menu-wrapper").getNiceScroll().resize();
        })
        $(".page-container").niceScroll();
        // nav init
        $("#leftMenu").metisMenu();

        // bootbox init
        bootbox.setLocale('zh_CN');

        // init footer height
        var footerEle= $(".footer");
        if(footerEle.length>0){
          footerEle.prev().css("height","calc(100% - 122px)")
        }
        
        //bootstrap select init
        $("#barSelect").selectpicker('value','{$gid}')
        $("#barSelect").on("changed.bs.select",function(e, clickedIndex, isSelected, previousValue) {
//          console.log(e)
//          console.log(clickedIndex)
//          console.log(isSelected)
//          console.log(previousValue)
//          console.log($(this).val())
        });

        
      }); 
    </script>
    {/literal}
</head>

<body>

  <nav class="left-nav">
    {if $logo}
      <div class="logo">logo</div>
    {/if}
    <div class="left-menu-wrapper">
      <ul id="leftMenu" class="nav left-menu">
          <li>
              <a>
                <span class="iconfont iconhome"></span>
                <span class="menu-label"> 系统首页</span>  
              </a>
          </li>
          <li>
            <a class="has-arrow">
              <span class="iconfont iconbook"></span>
              <span class="menu-label">账目明细</span>
            </a>
            <ul class="nav nav-second-level">
              <li><a href="#">收入汇总</a></li>
              <li><a href="#">交班明细</a></li>
              <li><a href="#">商品进销存明细</a></li>
              <li><a href="#">积分明细</a></li>
            </ul>
          </li>
          <li>
              <a class="has-arrow">
                <span class="iconfont iconstore"></span>
                <span class="menu-label">商品库存</span>
              </a>
              <ul class="nav nav-second-level">
                  <li><a>门店管理</a></li>
                  <li><a>库房管理</a></li>
                  <li><a>商品管理</a></li>
                  <li><a>进库/出库</a></li>
                  <li><a>盘点</a></li>
              </ul>
          </li>
          <li>
              <a class="has-arrow">
                <span class="iconfont iconchart"></span>
                <span class="menu-label">经营分析</span>
              </a>
              <ul class="nav nav-second-level">
                  <li><a>收入分析</a></li>
                  <li><a>经营分析</a></li>
                  <li><a>消费分析</a></li>
                  <li><a>消费排行</a></li>
              </ul>
          </li>
          <li>
              <a class="has-arrow">
                <span class="iconfont iconchart"></span>
                <span class="menu-label">卡券管理</span>
              </a>
              <ul class="nav nav-second-level">
                  <li><a>卡券管理</a></li>
                  <li><a>卡券明细</a></li>
              </ul>
          </li>
          <li>
              <a class="has-arrow">
                <span class="iconfont iconchart"></span>
                <span class="menu-label">门店管理</span>
              </a>
              <ul class="nav nav-second-level">
                  <li><a>门店管理</a></li>
                  <li><a></a></li>
                  <li><a>员工管理</a></li>
              </ul>
          </li>
          <li>
              <a>
                <span class="iconfont iconnote"></span>
                <span class="menu-label">操作日志</span>  
              </a>
          </li>
      </ul>
    </div>
  </nav>
  <div class="main-container">
    <div class="top-menu">
        <nav class="navbar-default">
            <div class="container-fluid">
              <div class="navbar-header">
                <button class="btn btn-link hamburger-btn"><span class="iconfont">&#xe77c;</span></button>
                <p class="navbar-text navbar-right">重要通知和提醒，请点击查看</p>
              </div>
          
              <div class="">
                <ul class="nav navbar-nav pull-right">
                  <li><a href="#">欢迎XXX</a></li>
                  <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true"> <span class="caret"></span> 账号</a>
                    <ul class="dropdown-menu pull-right">
                      <li><a href="#">信息</a></li>
                      <li><a href="#">修改密码</a></li>
                      <li><a href="#">账号安全</a></li>
                      <li role="separator" class="divider"></li>
                      <li><a href="#">退出登录</a></li>
                    </ul>
                  </li>
                </ul>
              </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
          </nav>
    </div>
    <ol class="breadcrumb">
      <li><a href="#">首页</a></li>
      <li><a href="#">系统</a></li>
      <li class="active">欢迎页</li>
    </ol>
    <div class="page-container">

