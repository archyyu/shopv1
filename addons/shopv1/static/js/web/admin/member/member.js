/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function () {

    Member.initGroups();

    Member.initTable();
    Member.refreshTable();
    
});

var Member = {

    groupsMap : {},

    uids : [],
    
    initGroups : function (){
        var groupsList = $('#groupsList').val();
        if (groupsList != "") {
            groupsList = JSON.parse(groupsList);
            for (var i = 0; i < groupsList.length; i++) {
                Member.groupsMap[groupsList[i].groupid] = groupsList[i];
            };
        };
        
    },

    initTable : function(){

        $("#memberList").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[
                {
                    checkbox: true
                },
                {
                    field: 'uid',
                    title: '会员编号'
                },
                {
                    field: 'nickname',
                    title: '昵称'
                },
                {
                    field: 'groupid',
                    title: '会员等级',
                    formatter: function (value, row, index) {
                        if (Member.groupsMap[value] == undefined) {
                            return "";
                        };
                        return Member.groupsMap[value].title;
                    }
                },
                {
                    field: 'mobile',
                    title: '手机'
                },
                {
                    field: 'email',
                    title: '邮箱',
                    formatter: function (value, row, index) {
                        return value;
                    }
                },
                {
                    field: 'credit2',
                    title: '余额'
                },
                {
                    field: 'credit1',
                    title: '积分'
                },
                {
                    field: 'createtime',
                    title: '注册时间',
                    formatter: function (value, row, index) {
                        return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
                    }
                },
                {
                    field: 'uid',
                    title: '操作',
                    formatter: function (value, row) {
                        return [
                            '<button class="btn btn-xs btn-success" onclick="Member.openSendCard(' + value + ');">发送卡券</button> ',
                            '<button class="btn btn-xs btn-danger" onclick="Member.deleterow(' + value + ');">删除</button>'
                        ].join("");
                    }
                }
            ]
        });
        
    },
    
    refreshTable : function(){
        $("#memberList").bootstrapTable("refreshOptions",{ajax:Member.reloadMembers});
    },
    
    reloadMembers : function(obj){
        
        var url = UrlUtil.createWebUrl('member',"loadMembers");
        
        var params = obj.data;
        params.timearea = $("#timearea").val();
        params.nickname = $("#nickname").val();
        params.moblie = $("#moblie").val();
        params.groupid = $("#groupid").val();
        //params.orderstate = $('input:radio[name="orderstate"]:checked').val();
        
        $.post(url, params, function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },

    sendCard : function(){
        var url = UrlUtil.createWebUrl('member',"sendCard");
        
        var params = {};
        params.uid = $("#uid").val();
        params.cardtypeid = $("#cardid").val();
        params.num = $("#num").val();
        params.cardname = $("#cardid option:selected").text();
        
        if (params.cardtypeid == 0) {
            Tips.failTips("请选择卡券");
            return;
        };

        if (params.num <= 0) {
            Tips.failTips("数量不符合规则");
            return;
        };

        $.post(url, params, function(data){
            if(data.state == 0){
                Tips.successTips("发送成功");
                $('#sendCard').modal('hide');
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    },

    massSendCard: function(){
        Member.uids = [];
        var memberList = $("#memberList").bootstrapTable('getSelections');

        var length = memberList.length;
        if(length > 0){
            var memberStr = [];
            for(var i = 0; i < length; i++){
                if (i == length - 1) {
                    memberStr.push("<span>" + memberList[i].nickname + "</span>");
                } else  {
                    memberStr.push("<span>" + memberList[i].nickname + "，</span>");
                }
                
                Member.uids.push(memberList[i].uid);
            }

            $("#sendMemberList").html(memberStr.join(''));
            $("#memberLength").text(length);
            $("#massSendCard").modal("show");
        }else{
            Tips.failTips('未选择用户');
        }
    },

    sendCards : function(){
        var url = UrlUtil.createWebUrl('member',"sendCards");
        
        var params = {};
        params.uids = Member.uids.join(',');
        params.cardtypeid = $("#masscardid").val();
        params.num = $("#massnum").val();
        params.cardname = $("#masscardid option:selected").text();
        
        if (params.cardtypeid == 0) {
            Tips.failTips("请选择卡券");
            return;
        };

        if (params.num <= 0) {
            Tips.failTips("数量不符合规则");
            return;
        };

        $.post(url, params, function(data){
            if(data.state == 0){
                Tips.successTips("发送成功");
                $('#massSendCard').modal('hide');
            }
            else{
                Tips.failTips(data.msg);
            }
        });
    },

    openSendCard : function(uid){
        $("#uid").val(uid);
        $("#cardid").val(0);
        $("#num").val("");
        $('#sendCard').modal('show');
    }

    
};
