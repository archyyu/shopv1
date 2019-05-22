$(function(){

	// BatchShipment.initTypes();
	// $("#selectProductList").niceScroll();
	// BatchShipment.initTable();
	// BatchShipment.refreshTable();
 
});

var BatchShipment = {

	productIdArr : [],			//存放进货商品ID

	productJsonArr : [],		//存放进货商品信息

	checkJsonArr : [],			//存放选中添加商品信息

	typesMap : {},				//初始化商品类型

	clkFlag : 0, 				//按钮点击标志

	initTypes : function(){
		
		var types = $('#types').val();
		if (types != "") {
			types = JSON.parse(types);
			for (var i = 0; i < types.length; i++) {
				BatchShipment.typesMap[types[i].id] = types[i];
			};
		};
	},

	initTable : function(){
		$("#BatchShipmentTable").bootstrapTable({
		    data: [],
		    showFooter: true,
		    footerStyle: BatchShipment.footerStyle,
		    columns: [{
		            field: 'typeid',
		            title: '类型',
		            formatter:function(value,row,index){
		            	if (BatchShipment.typesMap[value] == undefined) {
		            		return "";
		            	};
						return BatchShipment.typesMap[value].typename;
					}
		        },
		        {
		            field: 'name',
		            title: '商品名称'
		        },
		        {
		            field: 'unit',
		            title: '进货单位',
		            formatter:function(value,row,index){
		            	return value;
		    //         	if (BatchShipment.typesMap[value] == undefined) {
		    //         		return "";
		    //         	};
						// return BatchShipment.typesMap[value].typename;
					},
		            footerFormatter: function (value) {
						return '合计';
					}
		        },
		        {
		            field: 'price',
		            title: '进货价',
		            formatter:function(value,row,index){
						return [
	                        '<input type="text" value="' + value + '" field="price" onchange="BatchShipment.updateProduct(this, ' + index + ');" />'
	                    ].join("");
					}
		        },
		        {
		            field: 'num',
		            title: '进货数量',
		            formatter:function(value,row,index){
						return [
	                        '<input type="text" value="' + value + '" field="num" onchange="BatchShipment.updateProduct(this, ' + index + ');" />'
	                    ].join("");
					}
		        },
		        {
		            field: 'total',
		            title: '合计',
		            footerFormatter: BatchShipment.priceFormatter
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

	priceFormatter : function(data) {
	    var field = this.field;
	    var sum = 0;
	    data.map(function (row) {
	        sum += row[field]
	    });

	    BatchShipment.flushsum(sum);
	    $("#discount").attr("sum", sum);

	    return '<span>'+sum+'</span> 元';
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
        $("#BatchShipmentTable").bootstrapTable("load", BatchShipment.productJsonArr);
    },

	openStockDIV : function(){
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
	            json.typeid = $(this).attr("typeid");
	            json.price = 0;
	            json.num = 1;
	            json.total = 0;
	            // json.specid = "";
	            // json.volume = 1;
	            BatchShipment.checkJsonArr.push(json);
	        }
	    });
	    $("#checkNum").html(count);
	},

	discount : function(obj){
		var sum = $(obj).attr("sum");
		this.flushsum(parseFloat(sum));
	},

	flushsum : function(sum){
        var discount = parseFloat($("#discount").val());
        var subtotal = parseFloat((sum - discount).toFixed(2));
        $("#payPrice").text(subtotal);
	},

	repeal : function(){
		BatchShipment.productIdArr = [];
		BatchShipment.productJsonArr = [];

		$("#remark").val("");
		$("#discount").val("0");

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

		var url = UrlUtil.createWebUrl('product', 'saveStockOrder');
    
		$.post(url, params, function (data) {
			BatchShipment.clkFlag = 0;
			if (data.state == 0) {
				Tips.successTips("进货成功");
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
		var storage = $("#storage").val();
		var productJsonArr = BatchShipment.productJsonArr;
		var remark = $("#remark").val();
		var discount = $("#discount").val();
		//var storagename = $("#storageID option:selected").attr("name");

		if(storage == null || storage == ""){
			Tips.failToast("库房必选");
			return -1;
		}

		if(productJsonArr.length < 1){
			Tips.failToast("进货商品不能为空");
			return -1;
		}

		var params = {};
		params.storage = storage;
		params.productJson = productJsonArr;//JSON.stringify();
		params.remark = remark;
		params.discount = discount;
		params.payprice = parseFloat(parseFloat($("#payPrice").text()).toFixed(2));
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
		var column = $(obj).attr("field");

		var item = BatchShipment.productJsonArr[index];
		item[column] = obj.value;
		item.total = item.price * item.num;

		BatchShipment.productJsonArr[index][column] = item[column];
		BatchShipment.productJsonArr[index].total = item.total;

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




