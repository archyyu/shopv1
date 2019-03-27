$(function () {
  
  Member.memberListInit();
  Member.inputInit();
  Member.onlineListInit()
})
var Member = {

  // member list

  // refresh: function(){
  //   console.log('refresh')
  //   $('#memberList').bootstrapTable('refreshOptions',{ajax:MockData.memberList})
  // },
  memberListInit: function () {
    $('#memberList').bootstrapTable({
      ajax: MockData.memberList,
      height: 650,
      pagination: true,
      search: true,
      toolbar: "#toolbar",
      showColumns: true,
      showRefresh: true,
      paginationLoop:false,
      clickToSelect: true,
      pageSize: 25,
      columns: [{
          checkbox: true
        },
        {
          field: 'memberid',
          title: '会员ID'
        }, {
          field: 'account',
          title: '会员账号',
          titleTooltip: '会员账号'
        }, {
          field: 'weixin',
          title: '微信'
        }, {
          field: 'tel',
          title: '手机号'
        }, {
          field: 'name',
          title: '姓名'
        }, {
          field: 'sex',
          title: '性别'
        }, {
          field: 'level',
          title: '会员等级',
          filterControl: 'select'
        }, {
          field: 'online',
          title: '是否在线',
          formatter: function(value){
            var tag = ''
            if(value == "是"){
              tag = "<div class='tag tag-sm tag-success'>"+value+"</div>"
            }else{
              tag = "<div class='tag tag-sm tag-danger'>"+value+"</div>"
            }
            return tag
            
          }
        }, {
          field: 'game',
          title: '常玩游戏'
        }, {
          field: 'date',
          title: '注册时间'
        }, {
          field: 'memberid',
          title: '操作',
          formatter: function(value, row, index){
            return '<button class="btn btn-xs btn-warning">edit</button>'
          }
        }
      ]
    })
  },

  inputInit: function(){
    $('#createDate').daterangepicker({
      timePicker: true,
      timePicker24Hour: true,
      startDate: moment(),
      locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        format: 'YYYY/MM/DD HH:mm'
      }
    });
    $('#birthdate').daterangepicker({
      timePicker: true,
      timePicker24Hour: true,
      startDate: moment(),
      locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        format: 'YYYY/MM/DD HH:mm'
      }
    });
    $('#lastPlay').daterangepicker({
      timePicker: true,
      timePicker24Hour: true,
      startDate: moment(),
      locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        format: 'YYYY/MM/DD HH:mm'
      }
    });
  },

  // onlie list
  onlineListInit: function(){
    $('#onlineList').bootstrapTable({
      ajax: MockData.onlineList,
      height: 650,
      pagination: true,
      search: true,
      toolbar: "#toolbar",
      showColumns: true,
      showRefresh: true,
      paginationLoop:false,
      clickToSelect: true,
      pageSize: 25,
      columns: [{
          checkbox: true
        },
        {
          field: 'cardType',
          title: '卡类型'
        }, {
          field: 'account',
          title: '卡号',
          titleTooltip: '会员等级'
        }, {
          field: 'name',
          title: '姓名'
        }, {
          field: 'area',
          title: '区域'
        }, {
          field: 'pcName',
          title: '电脑'
        }, {
          field: 'balance',
          title: '消费金额'
        }, {
          field: 'cashBalance',
          title: '网费余额'
        }, {
          field: 'onlineType',
          title: '上机类型'
        }, {
          field: 'onlineTime',
          title: '上机时间 - 下机时间'
        }, {
          field: 'onlinePeriodTime',
          title: '上网时长'
        }, {
          field: 'operator',
          title: '操作员'
        }
      ]
    })
    
    $('#onlineDate').daterangepicker({
      timePicker: true,
      timePicker24Hour: true,
      startDate: moment(),
      locale: {
        applyLabel: '确定',
        cancelLabel: '取消',
        format: 'YYYY/MM/DD HH:mm'
      }
    })
  }
}