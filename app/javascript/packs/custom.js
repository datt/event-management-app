var Custom;
$(document).ready(function(){
  var s;
  Custom = {
    settings: {
      ajaxDefaults: {
        dataType: "script",
        type: "get",
        data: {},
        url: "/",
        async: true,
        blockUI: false
      },
      loaderCSS: {
        border: "none",
        padding: "15px",
        "-webkit-border-radius": "10px",
        "-moz-border-radius": "10px",
        opacity: .5,
        color: "#fff",
        text: "Please Wait."
      }
    },

    init: function() {
      s = this.settings;
      this.bindUIActions();
    },

    sendAjaxRequest: function(options) {
      var s = this.settings;
      ajaxOptions = $.extend({}, s.ajaxDefaults, options);
      $.ajax({
        async: ajaxOptions["async"],
        type: ajaxOptions["type"],
        url: ajaxOptions["url"],
        dataType: ajaxOptions["dataType"],
        data: ajaxOptions["data"],
        beforeSend: function(request) {
          if (ajaxOptions["blockUI"]) {
            return $.blockUI({
              css: s.loaderCSS
            });
          }
        },
        complete: function(request, json) {
          if (ajaxOptions["blockUI"]) {
            return $.unblockUI();
          }
        },
        success: function(data) {},
        error: function(data) {}
      });
    },

    bindUIActions: function() {
      // this.setHeading();
    },

    setHeading: function() {
      // $('h1').css('color', 'blue');
    }
  }
  Custom.init();
});