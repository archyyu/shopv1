/**
 * Created by Administrator on 2019/3/15.
 */

var Tips = {

  successTips: function(text){
    new Noty({
      text: text||'',
      type: 'success',
      theme: 'metroui',
      animation: {
          open: 'animated bounceInRight',
          close: 'animated bounceOutRight'
      },
      progressBar: true,
      timeout: 3000
    }).show();
  },

  failTips: function(text){
    new Noty({
      text: text||'',
      type: 'error',
      theme: 'metroui',
      animation: {
          open: 'animated bounceInRight',
          close: 'animated bounceOutRight'
      },
      progressBar: true,
      timeout: 5000
    }).show();
  },

  dangerTips: function(text){
    new Noty({
      text: text||'',
      type: 'error',
      theme: 'metroui',
      layout: 'top',
      animation: {
          open: 'animated bounceInRight',
          close: 'animated bounceOutRight'
      }
    }).show();
  },

  confirm: function(text, data, confirmFunc, cancelFunc){
    bootbox.confirm({
      size: 'small',
      message: text||'确认操作？', 
      callback: function(result){
        if(result){
          confirmFunc(data)
        }else{
          if(cancelFunc){
            cancelFunc()
          }
        }
      }
    })
  }

};