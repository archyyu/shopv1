
$(function(){
    Inventory.goodsTableInit();
});

var Inventory = {
    goodsTableInit: function(){
        $("#goodsTable").bootstrapTable({
            data: [{
                id: 1
            },
            {
                id: 2
            }],
            columns:[
                {
                    field:'id',
                    title:'ID'
                },
                {
                    field: 'id',
                    title: '商品名称'
                },
                {
                    field: 'id',
                    title: '商品分类'
                },
                {
                    field: 'id',
                    title: '销售价'
                },
                {
                    field: 'id',
                    title: '销量'
                },
                {
                    field: 'id',
                    title: '状态'
                },
                {
                    field: 'id',
                    title: '虚物/实物'
                },
                {
                    field: 'id',
                    title: '是否允许卡口'
                },
                {
                    field: 'id',
                    title: '关联商品'
                },
                {
                    field: 'id',
                    title: '销售时段'
                },
                {
                    field: 'id',
                    title: '排序'
                },
                {
                    field: 'id',
                    title: '操作'
                }]
        })
    },
    
    loadGoodsList:function(obj){
        
        var url = UrlUtil.createWebUrl('shop','loadShopList');
        var params = {};
        
        $.post(url,params,function(data){
            if(data.state == 0){
                obj.success(data.obj);
            }
            else{
                Tips.failTips(data.msg);
            }
        });
        
    },
}