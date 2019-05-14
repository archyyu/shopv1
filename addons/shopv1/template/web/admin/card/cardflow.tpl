{include file="../../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/css/waterbar.css">

<div class="card-flow">
    <div class="search-group">
        <div class="form-inline">
            <div class="form-group form-group-sm">
                <label class="control-label">时间起止</label>
                <input type="text" class="form-control range-picker-js">
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">发放门店</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券类型</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">搜索会员</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">使用门店</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券名称</label>
                <select class="form-control input-sm selectpicker">
                    <option value="">请选择</option>
                </select>
            </div>
            <div class="form-group form-group-sm">
                <label class="control-label">卡券状态</label>
                <labelclass="radio-inline">
                    <input type="radio"> 全部
                </label>
                <labelclass="radio-inline">
                    <input type="radio"> 已使用
                </label>
                <labelclass="radio-inline">
                    <input type="radio"> 未使用
                </label>
            </div>
            <button class="btn btn-sm btn-primary">搜索</button>
        </div>
    </div>
    <div class="card-info">
        <ul class="clearfix">
            <li>卡券总支出：<span>0</span> 张</li>
            <li>已使用：<span>0</span> 张</li>
            <li>使用率：<span>0</span> %</li>
        </ul>
    </div>
    <div class="detail_content">
        <table id="cardFlowTable" class="table">
        </table>
    </div>
</div>

{include file="./modals/addcard.tpl"}
{include file="./modals/sendcard.tpl"}
{include file="./modals/selectmember.tpl"}

<script src="{$StaticRoot}/js/web/card/cardManagement.js"></script>
<script>
    $(".range-picker-js").daterangepicker();
    $("#cardFlowTable").bootstrapTable({
        data: [{
                id: 1,
                text: 2
            },
            {
                id: 2,
                text: 3
            }
        ],
        columns: [{
                field: 'id',
                title: 'ID'
            },
            {
                field: 'id',
                title: '发放门店'
            },
            {
                field: 'id',
                title: '发放人'
            },
            {
                field: 'id',
                title: '会员昵称'
            },
            {
                field: 'id',
                title: '真实姓名'
            },
            {
                field: 'id',
                title: '手机号'
            },
            {
                field: 'id',
                title: '获得时间'
            },
            {
                field: 'id',
                title: '卡券名称'
            },
            {
                field: 'id',
                title: '卡券类型'
            },
            {
                field: 'id',
                title: '金额'
            },
            {
                field: 'id',
                title: '是否使用'
            },
            {
                field: 'id',
                title: '使用时间'
            },
            {
                field: 'id',
                title: '使用门店'
            },
            {
                field: 'id',
                title: '来源'
            },
            {
                field: 'text',
                title: '操作',
                formatter: function (value, row) {
                    return ['<button class="btn btn-xs btn-success">编辑</button> ',
                        '<button class="btn btn-xs btn-danger">删除</button>'
                    ].join("");
                }
            }
        ]
    });
</script>
{include file="../../common/footer.tpl"}