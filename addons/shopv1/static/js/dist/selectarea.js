var selectEle = {
  selectDown: function (thisEle, func) {
    var that = thisEle

    var selList = document.getElementsByClassName("rate-td-js");

    var isSelect = true;

    var evt = window.event || arguments[0];

    var startX = (evt.x || evt.clientX);

    var startY = (evt.y || evt.clientY);

    var selDiv = document.createElement("div");

    selDiv.style.cssText = "position:absolute;width:0px;height:0px;font-size:0px;margin:0px;padding:0px;border:1px dashed #0099FF;background-color:#C3D5ED;z-index:1000;filter:alpha(opacity:60);opacity:0.6;display:none;";

    selDiv.id = "selectDiv";

    document.body.appendChild(selDiv);

    selDiv.style.left = startX + "px";

    selDiv.style.top = startY + "px";

    var _x = null;

    var _y = null;

    this.clearEventBubble(evt);

    $(that).mousemove(function () {
      evt = window.event || arguments[0];

      if (isSelect) {

        if (selDiv.style.display == "none") {

          selDiv.style.display = "";

        }

        _x = (evt.x || evt.clientX);

        _y = (evt.y || evt.clientY);

        selDiv.style.left = Math.min(_x, startX) + "px";

        selDiv.style.top = Math.min(_y, startY) + "px";

        selDiv.style.width = Math.abs(_x - startX) + "px";

        selDiv.style.height = Math.abs(_y - startY) + "px";

        var _l = selDiv.offsetLeft,
          _t = $(selDiv).offset().top;

        var _w = selDiv.offsetWidth,
          _h = selDiv.offsetHeight;

        for (var i = 0; i < selList.length; i++) {

          var sl = $(selList[i]).innerWidth() + $(selList[i]).offset().left;

          var st = $(selList[i]).innerHeight() + $(selList[i]).offset().top;
          if (sl > _l && st > _t && $(selList[i]).offset().left < _l + _w && $(selList[i]).offset().top < _t + _h) {
            
            if (selList[i].className.indexOf("seled") == -1) {

              selList[i].className = selList[i].className + " seled";

            }

          } else {

            if (selList[i].className.indexOf("seled") != -1) {

              selList[i].className = "rate-td-js";

            }
          }
        }
      }

      selectEle.clearEventBubble(evt);

    });

    document.onmouseup = function () {
      isSelect = false;
$(selDiv).offset()
      if (selDiv) {

        document.body.removeChild(selDiv);

        func($(".seled"), _x, _y)

      }

      selList = null, _x = null, _y = null, selDiv = null, startX = null, startY = null, evt = null;

    }

  },
  clearEventBubble: function (evt) {

    if (evt.stopPropagation)

      evt.stopPropagation();

    else

      evt.cancelBubble = true;

    if (evt.preventDefault)

      evt.preventDefault();

    else

      evt.returnValue = false;

  }

}