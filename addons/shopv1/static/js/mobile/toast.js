/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var Toast={
  
    success:function(content){ 
        app.$createToast({
          txt: content,
          type: 'correct'
        }).show();
    },
    
    error:function(content){
        app.$createToast({
          txt: content,
          type: 'error'
        }).show();
    },
    
    info:function(){
        
    }
    
};