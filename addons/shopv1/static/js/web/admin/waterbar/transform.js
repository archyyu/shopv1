$(function(){
	$("#selectProductList").niceScroll();
	Transform.initTable();
 
});

var Transform = {
	initTable : function(){
		$("#transformTable").bootstrapTable({
		    data: [
				{ 
					id: 1 
				}
			],
		    showFooter: true,
		    footerStyle: Transform.footerStyle,
		    columns: [{
		            field: 'id',
		            title: '类型'
		        },
		        {
		            field: 'id',
		            title: '商品名称'
		        },
		        {
		            field: 'id',
		            title: '进货单位'
		        },
		        {
		            field: 'id',
		            title: '进货价'
		        },
		        {
		            field: 'id',
		            title: '进货数量'
		        },
		        {
		            field: 'id',
		            title: '合计',
		        },
		        {
		            field: 'id',
		            title: '操作'
		        }
		    ]
		})
	},

	footerStyle : function (column) {
	  return [
		  {
			  css: {'border-right': 0}
		  },
		  {
			  classes: 'none-border'
		  },
		  {
			  classes: 'none-border',
			  css: {'text-align': 'center'}
		  },
		  {
			  classes: 'none-border'
		  },
		  {
			  classes: 'none-border'
		  },
		  {
			  classes: 'footer-sum'
		  },
		  {
			  css: {'border-left' : 0}
		  }
	  ][column.fieldIndex];
  },

  openStockDIV : function(){
	//   $('#conForm')[0].reset();
	  $("#checkNum").html("0");
	  $('#transformMaterial').modal('show');
  },

  isCheck : function (obj){
	  if($(obj).attr("state") == 0){
		  $("#selectProductList input:checkbox[name='product[]']").prop('checked',true);
		  $(obj).attr("state",1);
		  BatchStock.count();
	  } else if($(obj).attr("state") == 1){
		  $("#selectProductList input:checkbox[name='product[]']").prop('checked',false);
		  $(obj).attr("state",0);
		  BatchStock.count();
	  }
  },

  clkDIV : function(obj){
	  if($(obj).children('input').prop('checked') == true){
		  $(obj).children('input').prop('checked', false);
	  } else{
		  $(obj).children('input').prop('checked', true);
	  }
  },
  
	info : function(data){
		console.log(data);
	}
};




