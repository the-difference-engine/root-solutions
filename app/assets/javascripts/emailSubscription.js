$(document).ready(function(){

  $(".footer-form-submit").click(function(){
    $.ajax({
      type   : "POST",
      url    : "/email_subscriptions",
      data   : { "email": $(".footer-email-bar").val() },
      success: function(data) {
        console.log("success");
        console.log(data);
        if($(".js-subscribe-response").html() == "") {
          $(".js-subscribe-response").html(data["message"]);
        } else {
          $(".js-subscribe-response").html("");
          $(".js-subscribe-response").html(data["message"]);
        }
      },
      error  : function(data) {
        console.log("failure");
      }
    });
  });

});