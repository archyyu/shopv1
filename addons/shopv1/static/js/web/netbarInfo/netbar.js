$(function () {

  $('#buildTime').daterangepicker({
    singleDatePicker: true,
    local: {
      format: 'YYYY/MM/DD'
    }
  });

  NetbarInfoLogic.tableListInit();
  NetbarInfoLogic.openAddModal();
  NetbarInfoLogic.addNetbar();
  NetbarInfoLogic.initAdd();
});

var NetbarInfoLogic = {

  tableListInit: function () {
    $('#barList').bootstrapTable({
      ajax: this.nerbarInfo,
      columns: [
        //   {
        //   checkbox: true
        // },
        {
          field: 'netbarname',
          title: '网吧名称'
        }, {
          field: 'address',
          title: '地址'
        }, {
          field: 'principal',
          title: '负责人'
        }, {
          field: 'thephone',
          title: '电话'
        }, {
          field: 'gid',
          title: '操作',
          events: NetbarInfoLogic.formbtnOpetare,
          formatter: function (value, row, index) {
            return '<button class="btn btn-xs btn-success edit-btn-js">编辑</button> ' +
              '<button class="btn btn-xs btn-danger del-btn-js">删除</button> '
          }
        }]
    })
  },

  addNetbar: function () {
    //王旭英
    $("button[name='add']").on('click', function () {
      var gid = $("input[name='gid']").val();
      var netbarname = $("input[name='netbarname']").val();
      var ifchain = $("select[name='ifchain']").val();
      var address = $("input[name='address']").val();
      var pcnum = $("input[name='pcnum']").val();
      var principal = $("input[name='principal']").val();
      var thephone = $("input[name='thephone']").val();
      var setuptime = $("input[name='setuptime']").val();
      var dataversion = $("input[name='dataversion']").val();
      $.ajax({
        url: UrlUtil.createWebUrl('netbarinfo', 'add'),
        type: 'POST',
        dataType: 'json',
        data: {
          'gid': gid,
          'netbarname': netbarname,
          'ifchain': ifchain,
          'address': address,
          'pcnum': pcnum,
          'principal': principal,
          'thephone': thephone,
          'setuptime': setuptime,
          'dataversion': dataversion
        },
        success: function (data) {
          console.log(data);
          if (data.state == 0) {
            Tips.successTips(data.msg);
            NetbarInfoLogic.nerbarInfo(NetbarInfoLogic);
            $("#addShop").modal('hide');
          } else {
            Tips.failTips(data.msg);
          }
        }

      });
    });
  },

  initAdd: function () {
    $("button[name='add_shop']").on('click', function () {
      $("h4[name='title']").html('新增门店');
      $("input[name='netbarname']").val('');
      $("input[name='pcnum']").val('');
      $("input[name='thephone']").val('');
      $("input[name='principal']").val('');
      $("input[name='setuptime']").val('');
      $("input[name='address']").val('');
      $("select[name='ifchain']").val('');
      $("input[name='gid']").val('');
      $("input[name='dataversion']").val('1');
    });
  },

  nerbarInfo: function (params) {
    $.ajax({
      url: UrlUtil.createWebUrl('netbarinfo', 'get'),
      //type: 'json',
      dataType: 'json',
      success: function (data) {
        params.success(data)
      }
    });
  },

  success: function (arr) {

    $('#barList').bootstrapTable('load', arr);

  },

  editBar: function (id) {
    $("h4[name='title']").html('编辑门店');
    $("#addShop").modal('show');
    $.post(UrlUtil.createWebUrl('netbarinfo', 'edit'), {
      'id': id
    }, function (res) {
      $("input[name='netbarname']").val(res.netbarname);
      $("input[name='pcnum']").val(res.pcnum);
      $("input[name='thephone']").val(res.thephone);
      $("input[name='principal']").val(res.principal);
      $("input[name='setuptime']").val(res.setuptime);
      $("input[name='address']").val(res.address);
      $("select[name='ifchain']").val(res.ifchain);
      $("input[name='gid']").val(res.gid);
      $("input[name='dataversion']").val(res.dataversion);
    }, 'json');
  },

  deleteBar: function (id) {
    Tips.confirm("确认删除门店？", {gid: id}, function (data) {
      console.log(data.gid);
      $.post(UrlUtil.createWebUrl('netbarinfo', 'del'), {'id': data.gid}, function (data) {
        console.log(data);
        if (data.state == 0) {
          Tips.successTips(data.msg);
          NetbarInfoLogic.nerbarInfo(NetbarInfoLogic);
        } else {
          Tips.failTips(data.msg);
        }
      }, 'json');
    })
  },

  formbtnOpetare: {
    'click .edit-btn-js': function (event, value, row, index) {
      NetbarInfoLogic.editBar(value);
    },
    'click .del-btn-js': function (event, value, row, index) {
      NetbarInfoLogic.deleteBar(value);
    }
  },

  openAddModal: function () {
    $("#addShop input").val('');
  }

};