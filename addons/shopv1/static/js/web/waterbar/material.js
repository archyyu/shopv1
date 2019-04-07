
$(function(){
    Material.materialTableInit();
});

var Material = {
    materialTableInit: function(){
        $("#materialTable").bootstrapTable({
            data: [{
                id: 1
            },
            {
                id: 2
            }],
            columns:[
                {
                    field:'id',
                    title:'编号'
                },
                {
                    field: 'id',
                    title: '类型'
                },
                {
                    field: 'id',
                    title: '名称'
                },
                {
                    field: 'id',
                    title: '库房'
                },
                {
                    field: 'id',
                    title: '单位'
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