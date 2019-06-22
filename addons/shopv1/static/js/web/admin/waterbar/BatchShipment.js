$(function(){

	$("#selectProductList").niceScroll();
	$('#addStockMaterial').on('shown.bs.modal', function (e) {
		$("#selectProductList").niceScroll().resize();
	})
	BatchShipment.initTable();
	BatchShipment.refreshTable();
 
});

var BatchShipment = {

	productIdArr : [],			//存放进货商品ID

	productJsonArr : [],		//存放进货商品信息

	checkJsonArr : [],			//存放选中添加商品信息

	clkFlag : 0, 				//按钮点击标志

	initTable : function(){
		$("#transformTable").bootstrapTable({
		    data: [],
		    showFooter: true,
		    footerStyle: BatchShipment.footerStyle,
		    columns: [{
		            field: 'name',
		            title: '商品名称'
		        },
		        {
		            field: 'unit',
		            title: '单位'
		        },
		        {
		            field: 'num',
		            title: '数量',
		            formatter:function(value,row,index){
						return [
	                        '<input type="text" value="' + value + '" onchange="BatchShipment.updateProduct(this, ' + index + ');" />'
	                    ].join("");
					}
		        },
		        {
		            field: 'id',
		            title: '操作',
	                formatter: function (value, row, index) {
	                    return [//'<button class="btn btn-xs btn-success">编辑</button> ',
	                        '<button class="btn btn-xs btn-danger" onclick="BatchShipment.remove(' + index + ', ' + value + ');">删除</button>'
	                    ].join("");
	                }
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

	refreshTable:function(){
        $("#transformTable").bootstrapTable("load", BatchShipment.productJsonArr);
    },

	openDIV : function(){
		$('#conForm')[0].reset();
		$("#checkNum").html("0");
		$('#addStockMaterial').modal('show');
	},

	isCheck : function (obj){
	    if($(obj).attr("state") == 0){
	        $("#selectProductList input:checkbox[name='product[]']").prop('checked',true);
	        $(obj).attr("state",1);
	        BatchShipment.count();
	    } else if($(obj).attr("state") == 1){
	        $("#selectProductList input:checkbox[name='product[]']").prop('checked',false);
	        $(obj).attr("state",0);
	        BatchShipment.count();
	    }
	},

	clkDIV : function(obj){
		if($(obj).children('input').prop('checked') == true){
			$(obj).children('input').prop('checked', false);
		} else{
			$(obj).children('input').prop('checked', true);
		}
	},

	count : function(){
	    var count = 0;
	    BatchShipment.checkJsonArr = [];
	    $("#selectProductList input:checkbox[name='product[]']").each(function(){
	        if(this.checked == 1){
	            count += 1;
	            var json = {};
	            json.id = this.value;
	            json.name = $(this).attr("productName");
	            json.unit = $(this).attr("unit");
	            json.num = 0;
	            BatchShipment.checkJsonArr.push(json);
	        }
	    });
	    $("#checkNum").html(count);
	},

	repeal : function(){
		BatchShipment.productIdArr = [];
		BatchShipment.productJsonArr = [];

		$("#remark").val("");

		BatchShipment.refreshTable();
	},

	save : function(){

		if(BatchShipment.clkFlag == 1){
			return ;
		}

		var params = this.validate();
		if(params == -1){
			return ;
		}
		
		BatchShipment.clkFlag = 1;

		var url = UrlUtil.createWebUrl('product', 'saveBatchShipment');
    
		$.post(url, params, function (data) {
			BatchShipment.clkFlag = 0;
			if (data.state == 0) {
				Tips.successTips("调货成功");
				BatchShipment.repeal();
			} else {
				Tips.failTips(data.msg);
			}
		}, 'json').error(function(e){
			console.log(e);
			BatchShipment.clkFlag = 0;
		});

	},

	validate : function(){
		var sourceid = $("#sourceid").val();
		var destinationid = $("#destinationid").val();
		var productJsonArr = BatchShipment.productJsonArr;
		var remark = $("#remark").val();

		if(!sourceid && !destinationid){
			Tips.failTips("调货库房必选");
			return -1;
		}

		if(sourceid == destinationid){
			Tips.failTips("同库不能调动");
			return -1;
		}

		if(productJsonArr.length < 1){
			Tips.failTips("调货商品不能为空");
			return -1;
		}

		var params = {};
		params.sourceid = sourceid;
		params.destinationid = destinationid;
		params.productJson = productJsonArr;
		params.remark = remark;
		return params;
	},

	addProduct : function(){
		var list = BatchShipment.checkJsonArr;
		for(var i = 0; i < list.length; i++){
			if(BatchShipment.productIdArr.indexOf(list[i].id) < 0){
				BatchShipment.productIdArr.push(list[i].id);
				BatchShipment.productJsonArr.push(list[i]);
			}
		}

		//刷新模板
		BatchShipment.refreshTable();
		$('#addStockMaterial').modal('hide');
	},

	updateProduct : function(obj, index){

		BatchShipment.productJsonArr[index].num = obj.value;
		BatchShipment.refreshTable();
	},

	remove : function(index, id){
		BatchShipment.productJsonArr.splice(index, 1);
		BatchShipment.productIdArr.shift(id);

        BatchShipment.refreshTable();
	},

	info : function(data){
		console.log(data);
	}
};




