{include file="../common/header.tpl" logo=true}
<link rel="stylesheet" href="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.css">
<link rel="stylesheet" href="{$StaticRoot}/css/netbarInfo.css">

 <div class="bar-select">
   <label class="control-label">门店：</label>
   <select id="shopSelect" class="mysele" data-live-search="true" data-size="6">

     {foreach $shopList as $store}
     <option value='{$store.id}'>{$store.shopname}</option>
     {/foreach}

   </select>
 </div>

 <div class="staff-list">
   <div class="staff">
     <div class="add-staff-list">
       <button class="btn btn-sm btn-success" data-toggle="modal" onclick="Staff.openStaffModal(0,null);">添加员工</button>
     </div>
     <div class="staff-group-table">
       <table id="staffListTable" class="table table-bordered">
         <thead>
           <tr>
             <th>头像</th>
             <th>姓名</th>
             <th>账号</th>
           </tr>
         </thead>
       </table>
     </div>
   </div>
 </div>

 <!-- add sraff modal -->
 <div id="addStaffModal" class="modal fade add-staff-modal" role="dialog">
   <div class="modal-dialog" role="document">
     <input type="hidden" value="0" name="userid" />
     <div class="modal-content">
       <div class="modal-header">
         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
         <h4 class="modal-title" name="title">添加员工</h4>
       </div>
       <div class="modal-body">
         <div class="form-horizontal">
           <div class="form-group form-group-sm">
             <label class="col-xs-3 control-label">账号</label>
             <div class="col-xs-8">
               <input class="form-control" name="account">
             </div>
           </div>
           <div class="form-group form-group-sm">
             <label class="col-xs-3 control-label">密码</label>
             <div class="col-xs-8">
               <input class="form-control" name="password" type="password">
             </div>
           </div>
           <div class="form-group form-group-sm">
             <label class="col-xs-3 control-label">性别</label>
             <div class="col-xs-8">
               <select class="form-control" name="sex">
                 <option value="0">男</option>
                 <option value="1">女</option>
               </select>
             </div>
           </div>
           <div class="form-group form-group-sm">
             <label class="col-xs-3 control-label">手机号</label>
             <div class="col-xs-8">
               <input class="form-control" name="phone">
             </div>
           </div>
           <div class="form-group form-group-sm">
             <label class="col-xs-3 control-label">OPENID</label>
             <div class="col-xs-8">
               <input class="form-control" name="openid">
             </div>
           </div>
         </div>
       </div>
       <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal">取 消</button>
         <button type="button" class="btn btn-primary" onclick="Staff.saveStaff();" name="add">确 认</button>
       </div>
     </div><!-- /.modal-content -->
   </div>
 </div><!-- /.modal -->

<script src="{$StaticRoot}/plugins/jquery-timepicker/jquery.timepicker.min.js"></script>
<script src="{$StaticRoot}/js/web/admin/staff.js"></script>

{include file="../common/footer.tpl"}
