/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
   
   Banner.bannerTableInit();
   Banner.bannerTableReload();
    
});

$("#shopSelect").change(function(){
     Banner.bannerTableReload();
});

var Banner={
    
    bannerTableInit:function(){
        $("#bannerListTable").bootstrapTable({
            data:[],
            columns:[{
                        field:'index',
                        title:'优先级'
                    },{
                        field:'imgurl',
                        title:'预览图',
                        formatter:function(value,row,index){
                            let url = UrlUtil.getWebBaseUrl() + value;
                            return '<img src="' + url + '" alt="logo">';
                        }
                    },{
                        field:'id',
                        title:'操作',
                        events:{
                            'click .edit-event':function(e,value,row,index){
                                //Staff.openStaffModal(1,row);
                                Banner.removeBanner(value);
                            }
                        },
                        formatter:function(value,row,index){
                            return '<button class="btn btn-xs btn-success edit-event">删除</button> ';
                        }
                    }
            ]
        });
    },
    
    uploadLogo: function(iputId, imgId, width, height){
        setMultiImagePreview(iputId,imgId,width,height);
        $(".upload-area").addClass('show-pic');
      },
    
    bannerTableReload:function(){
        $("#bannerListTable").bootstrapTable("refreshOptions",{ajax:Banner.loadBanner});
    },
    
    loadBanner:function(obj){
        
        let url = UrlUtil.createWebUrl("shop","loadBannerList");
        
        let params = {};
        params.shopid = $("#shopSelect").val();
        
        $.post(url,params,function(data){
           obj.success(data.obj); 
        });
        
    },
    
    openModal:function(){
        $("#addBannerModal").modal("show");
    },
    
    removeBanner:function(id){
        
        let url = UrlUtil.createWebUrl("shop","removeBanner");
        
        let params = {};
        params.id = id;
        
        $.post(url,params,function(data){
            if(data.state == 0){
                Tips.successTips("删除了");
                Banner.bannerTableReload();
            }
        });
        
    },
    
    saveBanner:function(){
        let url = UrlUtil.createWebUrl("shop","saveBanner");
        
        let data = new FormData();
        data.append("index",$("#addBannerModal [name=index]").val());
        data.append("shopid",$("#shopSelect").val());
        data.append("imgurl",document.getElementById("logoInput").files[0]);
        
        $.ajax({
                url: url,
                type: 'POST',
                dataType: 'json',
                data: data,
                async: false,
                processData: false,
                contentType: false,
                success: function (data) {
                    if(data.state == 0){
                        Tips.successTips("保存成功");
                        $("#addBannerModal").modal("hide");
                        Banner.bannerTableReload();
                    }
                    else{
                        Tips.failTips(data.msg);
                    }
                }
                
            }); 
        
    },
    
    info:function(){
        
    }
    
    
};