 <div class="modal fade" id="productClassModal" role="dialog" aria-hidden="true">
   <div class="modal-dialog productClass">
     <div class="modal-content">
       <div class="modal-header">
         <h5 class="modal-title text-center">商品分类</h5>
       </div>
       <div class="modal-body">
         <div class="productClass_pop">
           <div class="row ">
             <div class="col-sm-3 ">
               <button class="btn btn-sm btn-block btn-primary addClass" onclick="addType()">添加分类</button>
             </div>
           </div>
           <div class="row addClass_table ">
             <div class="col-sm-12 ">
               <div id="typeTabTemplate">
                 <table class="table table-bordered text-center " id="typeListTab">
                   <thead>
                     <tr>
                       <th>排序</th>
                       <th>类别</th>
                       <th colspan="2 ">操作</th>
                     </tr>
                   </thead>
                   <tbody>
                     <tr id="typeid_{$T.record.id}">
                       <td>{$T.record.position}</td>
                       <td>{$T.record.name}</td>
                       <td>
                         <button class="btn btn-link btn-xs edit">编辑</button>
                       </td>
                       <td>
                         <button class="btn btn-xs btn-link delete">删除</button>
                       </td>
                     </tr>
                   </tbody>
                 </table>
               </div>
             </div>
           </div>
         </div>
       </div>
       <div class="modal-footer">
         <div class="row addProduct_btn ">
           <div class="col-md-offset-3 col-md-6 text-center ">
             <button class="btn btn-default" data-dismiss="modal">关&nbsp;&nbsp;&nbsp;&nbsp;闭</button>
           </div>
         </div>
       </div>
     </div>
   </div>
 </div>