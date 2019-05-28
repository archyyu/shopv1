/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function () {
    Member.initTable();
    Member.refreshTable();
    
});

var Member = {

    initTable : function(){

        $("#memberList").bootstrapTable({
            data:[],
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns:[
                {
                    field: 'uid',
                    title: '会员编号'
                }, {
                    field: 'nickname',
                    title: '昵称'
                }, {
                    field: 'mobile',
                    title: '手机'
                }, {
                    field: 'email',
                    title: '邮箱',
                    formatter: function (value, row, index) {
                        return value;
                    }
                }, {
                    field: 'credit2',
                    title: '余额'
                }, {
                    field: 'credit1',
                    title: '积分'
                }, {
                    field: 'createtime',
                    title: '注册时间',
                    formatter: function (value, row, index) {
                        return new Date(parseInt(value) * 1000).toLocaleString().replace(/:\d{1,2}$/,' ');
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
        // params.timearea = $("#timearea").val();
        // params.orderstate = $('input:radio[name="orderstate"]:checked').val();
        // params.userid = $("#usersList").val();
        // params.shopid = $("#shopSelect").val();
        
        $.post(url, params, function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    }
    
};
