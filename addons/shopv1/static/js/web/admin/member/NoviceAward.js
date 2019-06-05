/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(function(){
    
    $('#cardtypeid').change(function(){
        NoviceAward.change('cardtypeid', this.value);
    });
    
    $('#points').on('input',function(){
      NoviceAward.change('points', this.value);
  });

});

var NoviceAward = {
    
  change : function (f, v){
      var url = UrlUtil.createWebUrl('member',"saveNoviceAward");
      
      var params = {};
      params.awardid = $("#awardid").val();
      params.field = f;
      params.val = v;

      $.post(url,params,function(data){
        console.log(data);
          if(data.state == 0){
              Tips.successTips("保存成功");
          }
          else{
              Tips.failTips(data.msg);
          }
      }).error(function(e){
        console.log(e);
      });
  }
    
};