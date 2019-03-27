$(function () {

  $('#buildTime').daterangepicker({
    singleDatePicker: true,
    local: {
      format: 'YYYY/MM/DD'
    }
  });

  NetbarInfoLogic.getAreaApi();
  NetbarInfoLogic.changeNetBar();
  NetbarInfoLogic.initData();
});

var NetbarInfoLogic = {
  cancelRate: function () {
    $("#rateSettingCard").hide();
    $("#rateInput").val("0");
    $(".seled").removeClass('seled');
  },

  confirmRate: function () {
    var rate = $("#rateInput").val();
    $(".seled").text(rate);
    this.cancelRate();
    var str = this.getTableHtml();
    var res = this.weekRateSave(str);
  },

  /**
   * 获取table里每个格子的值
   * @returns {string}
   */
  getTableHtml: function () {
    //添加周-时间费率
    var str = '';
    var objTable = document.getElementById("rateTable");

    for (var i = 1; i < objTable.rows.length; i++) {
      for (var j = 0; j < objTable.rows[i].cells.length; j++) {
        rate = objTable.rows[i].cells[j].innerHTML;
        str += rate + ',';
      }
    }
    return str;
  },

  /**
   * 保存table格子里的值
   * @param rateName
   */
  weekRateSave: function (rateName) {
    var id = $("input[name='id']").val();
    var url = this.getUrl('savePriceApi');
    $.post(url, {'id': id, 'price': rateName}, function (date) {
      if (date.state == 0) {
        Tips.successTips(date.msg);
      } else {
        Tips.failTips(date.msg);
      }
    }, 'json');
  },

  showRatemodal: function name(arr, modalX, modalY) {
    if (arr.length > 0) {
      var card = $("#rateSettingCard")
      card.css({
        top: 0,
        left: 0
      })
      var tableHei = $("#rateTable>tbody").innerHeight();
      var tableWid = $("#rateTable>tbody").innerWidth();
      var navWid = $("#leftMenu").innerWidth();
      if ($("#rateSettingCard").is(":visible")) {
        card.offset({
          top: (modalY - 150) > tableHei ? (modalY - 80) : modalY,
          left: (modalX - navWid + 270) > tableWid ? (modalX - 310) : modalX
        });
      } else {
        card.offset({
          top: (modalY - 150) > tableHei ? (modalY - 80) : modalY,
          left: (modalX - navWid + 270) > tableWid ? (modalX - navWid - 310) : (modalX - navWid)
        });
      }
      card.show();

    }
  },

  selectRate: function (that) {
    selectEle.selectDown(that, NetbarInfoLogic.showRatemodal);
  },

  // 切换区域
  changeArea: function (that, id) {
    if (!$(that).hasClass("active")) {
      $(that).addClass("active").siblings().removeClass("active");
      NetbarInfoLogic.initData();
    }
  },

  //获取区域接口
  getAreaApi: function () {
    var gid = this.getGid();

    var url = UrlUtil.createWebUrl('RateSet', 'getAreaApi');

    $.ajax({
      type: "post",
      url: url,
      data: {'gid': gid},
      dataType: "json",
      async: false,
      success: function (data) {
        if (data.state == 0) {
          var smartyjs = new jSmart($("#areaList").html());
          var output = smartyjs.fetch({data: data.obj});
          $("#areaNav").html(output);
        }
      }

    });
  },

  //改变网吧事件
  changeNetBar: function () {
    $("#barSelect").on('change', function () {
      NetbarInfoLogic.getAreaApi();
      NetbarInfoLogic.initData();
    });
  },

  //保存数据
  saveRate: function () {
    var url = UrlUtil.createWebUrl('RateSet', 'saveRateApi');
    var params = {};
    params.typeid = this.getTypeId();
    params.ignoretime = $("input[name='ignoretime']").val();
    params.startprice = $("input[name='startprice']").val();
    params.mincostprice = $("input[name='mincostprice']").val();
    params.id = $("input[name='id']").val();
    params.gid = this.getGid();
    params.areaid = this.getAreaId();
    $.post(url, params, function (data) {
      if (data.state == 0) {
        Tips.successTips(data.msg);
        $("input[name='id']").val(data.obj.lastInsertId);
      } else {
        Tips.failTips(data.msg);
      }
    }, 'json');
  },

  //初始化数据
  initData: function () {
    var params = {};
    params.gid = this.getGid();
    params.areaid = this.getAreaId();
    params.typeid = this.getTypeId();
    var url = this.getUrl('getListApi');
    $.post(url, params, function (data) {
      if (data.state == 0) {
        var obj = data.obj;
        var price = data.obj.price;
        if (obj) {
          $("input[name='startprice']").val(obj.startprice);
          $("input[name='mincostprice']").val(obj.mincostprice);
          $("input[name='ignoretime']").val(obj.ignoretime);
          $("input[name='id']").val(obj.id);
          if (price.length > 1) {
            var i = 0;
            $.each($("#rateTable .rate-td-js"), function (key, val) {
              val.innerHTML = price[i];
              i++;
            });
          } else {
            $(".rate-td-js").html(0);
          }
        } else {
          $("input").val('');
        }
      }
    }, 'json');
  },

  /**
   * 点击会员类型
   * @param typeid
   */
  clickMemberType: function (typeid) {
    $("div[name='clicktypeid']").removeClass('active');
    $("div[name='clicktypeid'][value='" + typeid + "']").addClass('active');
    $("input[name='typeid']").val(typeid);
    NetbarInfoLogic.initData();
  },

  //获取url
  getUrl: function (action) {
    var url = UrlUtil.createWebUrl('RateSet', action);
    return url;
  },

  //获取gid
  getGid: function () {
    var gid = $("#barSelect").val();
    return gid;
  },

  //获取区域id
  getAreaId: function () {
    var areaid = $("#areaNav .active").attr('value');
    return areaid;
  },

  /**
   * 获取typeid
   * @returns {*|jQuery}
   */
  getTypeId: function () {
    var typeid = $("input[name='typeid']").val();
    return typeid;
  }

};