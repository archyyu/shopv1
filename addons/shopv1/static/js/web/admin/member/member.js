/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function () {
    Member.inittableList();
    
});

var Member = {

    getLists: function(params){
        $("#memberTypeSelect").selectpicker();
        return params.success()
    },

    inittableList: function () {
        $("#memberList").bootstrapTable({
            ajax: Member.getLists,
            sidePagination: "server",
            pageSize: 10,
            pagination: true,
            columns: [
                {
                    field: 'account',
                    title: '账号'
                }, {
                    field: 'membername',
                    title: '会员名称'
                }, {
                    field: 'membertype',
                    title: '会员等级'
                }, {
                    field: 'state',
                    title: '状态',
                    formatter: function (value, row, index) {
                        if (value == 1) {
                            return '启用';
                        } else {
                            return '未启用';
                        }
                    }
                }, {
                    field: 'balance',
                    title: '余额'
                }, {
                    field: 'createdate',
                    title: '开卡时间'
                }, {
                    field: 'lastoffdate',
                    title: '最后下机时间'
                }
            ]
        });
        
    },
    
    refresh: function () {
        $('#mymemberList').bootstrapTable('refresh');
    }
    
    
};
