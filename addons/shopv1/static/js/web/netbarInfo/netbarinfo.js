$(function () {

  $('#buildTime').daterangepicker({
    singleDatePicker: true,
    local: {
      format: 'YYYY/MM/DD'
    }
  });

  NetbarInfoLogic.clickRadio();
  NetbarInfoLogic.addArea();
  NetbarInfoLogic.deleteArea();
  NetbarInfoLogic.netbarSelect();
  NetbarInfoLogic.macSearch();
  NetbarInfoLogic.initAreaComputer();
});

var NetbarInfoLogic = {

    openInfoPanel: function () {

    },

    initAreaComputer: function () {
      var id = $("#areaNav li[class='active']").attr('value');
      NetbarInfoLogic.changeArea('', id);
    },

    netbarSelect: function () {
      $("#barSelect").on('change', function () {
        var gid = $(this).val();
        window.location.href = UrlUtil.createWebUrl('netbarinfo', 'area') + '&gid=' + gid;
      });
    },

    updateInfo: function () {

    },

    deleteInfo: function () {

    },

    // 切换区域
    changeArea: function (that, id) {
      if (!$(that).hasClass("active")) {
        $(that).addClass("active").siblings().removeClass("active");
      }
      $.post(UrlUtil.createWebUrl('netbarinfo', 'getMemberType'), {'areaid': id}, function (data) {
        $("input[type='checkbox'][name='membertypelist']").removeAttr('checked');
        var memberType = data.membertypelist;
        var groupMac = data.groupMac;
        if(groupMac) {
          var str = '';
          $("select[name='groupMac']").empty();
          for (var i = 0; i < groupMac.length; i++) {
            str += "<option value='" + groupMac[i].machineid + "'>" + groupMac[i].machinename + "</option>";
          }
          $("select[name='groupMac']").append(str);
        }
        if (memberType) {
          $.each(memberType, function (key, val) {
            $("input[type='checkbox'][name='membertypelist'][value='" + val + "']").prop('checked', true);
          });
        }
      }, 'json');
    },
    // 添加区域
    addAreaBtn: function () {
      $("#rateInput").val("");
      $("#rateInput").removeAttr("areaid");
      $('#areaSettingCard').show()
    },

    // 编辑区域
    editAreaBtn: function () {
      var id = this.getAreaId();
      var barName = $("#areaNav li.active").text();
      $("#rateInput").val(barName);
      $("#rateInput").attr('areaid', id);
      $('#areaSettingCard').show()
    },

    //获取区域id公共方法
    getAreaId: function () {
      var areaid = $("#areaNav li[class='active']").attr('value');
      return areaid;
    },

    // 删除区域
    delAreaBtn: function () {
      var areaid = this.getAreaId();
      Tips.confirm("确认删除区域？", {gid: 1}, function (data) {
        $.post(UrlUtil.createWebUrl('netbarinfo', 'delBarArea'), {'id': areaid}, function (data) {
          console.log(data);
          if (data.state == 0) {
            Tips.successTips(data.msg);
            window.location.reload();
          } else {
            Tips.failTips(data.msg);
          }
        }, 'json');
      });
    },

    // 确认添加区域
    confirmAreaBtn: function () {
      var areaid = $("#rateInput").attr('areaid');
      var name = $("#rateInput").val();
      var gid = $("#barSelect").val();
      $.post(UrlUtil.createWebUrl('netbarinfo', 'saveBarArea'), {
        'areaname': name,
        'gid': gid,
        'state': 1,
        'dataversion': 1,
        'areaid': areaid
      }, function (data) {
        console.log(data);

        if (data.state == 0) {
          var area = data.obj;
          var str = '';
          $("#areaNav").empty();
          var my_areaid = '';
          for (var i = 0; i < area.length; i++) {
            if (area[i].areaname == name) {
              my_areaid = area[i].areaid;
              str += '<li onclick="NetbarInfoLogic.changeArea(this,' + area[i].areaid + ')" value="' + area[i].areaid + '" class="active" >' + area[i].areaname + '</li>';
            } else {
              str += '<li onclick="NetbarInfoLogic.changeArea(this,' + area[i].areaid + ')" value="' + area[i].areaid + '" >' + area[i].areaname + '</li>';
            }
          }
          $("#areaNav").append(str);
          var my_obj = $('#areaNav li:last-child');
          $('#areaSettingCard').hide();
          NetbarInfoLogic.changeArea('', my_areaid);
          Tips.successTips(data.msg);
        } else {
          Tips.failTips(data.msg);
        }
      }, 'json');
    },

    //搜索电脑名称
    macSearch: function () {
      $("input[name='search']").on('input', function () {
        var key = $(this).val();
        var gid = $("#barSelect").val();
        $.post(UrlUtil.createWebUrl('netbarinfo', 'getMacList'), {'key': key, 'gid': gid}, function (data) {
          var str = '';
          $("select[name='allMac']").empty();
          for (var i = 0; i < data.length; i++) {
            str += "<option value='" + data[i].machineid + "'>" + data[i].machinename + "</option>";
          }
          $("select[name='allMac']").append(str);
        }, 'json');
      });
    },

    areaSearch: function () {
      var key = $("input[name='areaSearch']").val();
      var gid = $("#barSelect").val();
      var areaid = this.getAreaId();
      $.post(UrlUtil.createWebUrl('netbarinfo', 'getAreaMacList'), {
        'key': key,
        'gid': gid,
        'areaid': areaid
      }, function (data) {
        console.log(data);
        var str = '';
        $("select[name='groupMac']").empty();
        for (var i = 0; i < data.length; i++) {
          str += "<option value='" + data[i].machineid + "'>" + data[i].machinename + "</option>";
        }
        $("select[name='groupMac']").append(str);
      }, 'json');
    },

    clickRadio: function () {
      $("input[name='type'][type='radio']").on('click', function () {
        var type = $(this).val();
        if (type == 1) {
          $('#addMutiPc').hide();
          $("input[name='name']").show();
        } else {
          $("input[name='name']").hide();
          $('#addMutiPc').show();
        }
      });
    }
    ,

    // 添加机器
    addArea: function () {
      $("button[name='save_area']").on('click', function () {
        var pre_name = $("input[name='pre_name']").val();
        var name = $("input[name='name']").val();
        var start_name = $("input[name='start_name']").val();
        var end_name = $("input[name='end_name']").val();
        var type = $("input[name='type']:checked").val();
        var gid = $("#barSelect").val();
        $.post(UrlUtil.createWebUrl('netbarinfo', 'saveArea'), {
          'preName': pre_name,
          'name': name,
          'startName': start_name,
          'endName': end_name,
          'type': type,
          'gid': gid
        }, function (data) {
          console.log(data);
          if (data.state == 0) {
            var res = data.obj;
            var str = '';
            $("select[name='allMac']").empty();
            for (var i = 0; i < res.length; i++) {
              str += "<option value='" + res[i].machineid + "'>" + res[i].machinename + "</option>";
            }
            $("select[name='allMac']").append(str);
            Tips.successTips(data.msg);
            $('#addPc').hide();
            $('.in').hide();
          } else {
            Tips.failTips(data.msg);
          }
        }, 'json');
      });
    },

    addMemberType: function () {
      var packageCodeList = new Array();
      var areaid = this.getAreaId();
      $('input[name="membertypelist"]:checked').each(function () {
        packageCodeList.push($(this).val());//向数组中添加元素
      });
      $.post(UrlUtil.createWebUrl('netbarinfo', 'addMemberType'), {
        'membertypelist': packageCodeList,
        'areaid': areaid
      }, function (data) {
        console.log(data);
        if (data.state == 0) {
          Tips.successTips(data.msg);
        } else {
          Tips.failTips(data.msg);
        }
      }, 'json');
    },

    // 删除机器
    deleteArea: function () {
      $("button[name='delArea']").on('click', function () {
        var id = $("select[name='allMac']").val();
        var gid = UrlUtil.getQueryString('gid');
        Tips.confirm("确认删除机器？", {gid: 1}, function (data) {
          $.post(UrlUtil.createWebUrl('netbarinfo', 'delArea'), {'id': id,'gid':gid}, function (data) {
            if (data.state == 0) {
              var res = data.obj;
              var str = '';
              $("select[name='allMac'] option:selected").remove();
              for (var i = 0; i < res.length; i++) {
                str += "<option value='" + res[i].machineid + "'>" + res[i].machinename + "</option>";
              }
              $("select[name='allMac']").append(str);
              Tips.successTips(data.msg);
            } else {
              Tips.failTips(data.msg);
            }
          }, 'json');
        });
      });
    },

    info: function () {

    },

    groupMac: function ($sign) {
      var optionStr = '';
      if ($sign == 2) {
        $("select[name='allMac'] option").each(function () {
          optionStr += $(this).val() + ",";
        });
      } else {
        $("select[name='allMac'] option:selected").each(function () {
          optionStr += $(this).val() + ",";
        });
      }
      var areaid = this.getAreaId();
      $.post(UrlUtil.createWebUrl('netbarinfo', 'groupMac'), {
        'machineid': optionStr,
        'areaid': areaid
      }, function (res) {
        var data = res.obj;
        if (res.state == 0) {
          if ($sign == 2) {
            $("select[name='allMac'] option").remove();
          } else {
            $("select[name='allMac'] option:selected").remove();
          }
          var str = '';
          $("select[name='groupMac']").empty();
          for (var i = 0; i < data.length; i++) {
            str += "<option value='" + data[i].machineid + "'>" + data[i].machinename + "</option>";
          }
          $("select[name='groupMac']").append(str);
        } else {
          Tips.failTips(res.msg);
        }

      }, 'json');
    },

    /**
     * 去除选择区域的计算机
     */
    removeOneMac: function ($sign) {
      var optionStr = '';
      if ($sign == 2) {
        $("select[name='groupMac'] option").each(function () {
          optionStr += $(this).val() + ",";
        });
      } else {
        $("select[name='groupMac'] option:selected").each(function () {
          optionStr += $(this).val() + ",";
        });
      }

      var areaid = this.getAreaId();
      var gid = UrlUtil.getQueryString('gid');
      $.post(UrlUtil.createWebUrl('netbarinfo', 'removeOneMac'), {
        'machineid': optionStr,
        'areaid': areaid,
        'gid': gid
      }, function (res) {
        var data = res.obj;
        console.log(res);
        if (res.state == 0) {
          if ($sign == 2) {
            $("select[name='groupMac'] option").remove();
          } else {
            $("select[name='groupMac'] option:selected").remove();
          }
          var str = '';
          $("select[name='allMac']").empty();
          for (var i = 0; i < data.length; i++) {
            str += "<option value='" + data[i].machineid + "'>" + data[i].machinename + "</option>";
          }
          $("select[name='allMac']").append(str);
        } else {
          Tips.failTips(res.msg);
        }

      }, 'json');
    },

    getComputerNum: function () {
      var start_name = $("input[name='start_name']").val();
      var end_name = $("input[name='end_name']").val();
      $.post(UrlUtil.createWebUrl('netbarinfo', 'getComputerNum'), {
        'start_name': start_name,
        'end_name': end_name
      }, function (data) {
        $('#PcNum').html(data.num);
      }, 'json');
    },

    groupAllMac: function () {
      var optionStr = '';
      $("select[name='allMac'] option").each(function () {
        optionStr += $(this).val() + ",";
      });
      var areaid = this.getAreaId();
      console.log(optionStr);
    }
  };