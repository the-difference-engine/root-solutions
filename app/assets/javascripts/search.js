$(document).ready(function() {
  $('.existing-filter-display-wrap').hide();
  
  // Configure/customize these variables.
  var showChar = 300;  // How many characters are shown by default
  var ellipsestext = "...";
  var moretext = "Read More";
  var lesstext = "Read Less";
  $('.more').each(function() {
    var content = $(this).html();
    if(content.length > showChar) {
      var c = content.substr(0, showChar);
      var h = content.substr(showChar, content.length - showChar);
      var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
      $(this).html(html);
    }
  });
  $("body").on("click", ".morelink", function(){
    if($(this).hasClass("less")) {
      $(this).removeClass("less");
      $(this).html(moretext);
    } else {
      $(this).addClass("less");
      $(this).html(lesstext);
    }
    $(this).parent().prev().toggle();
    $(this).prev().toggle();
    return false;
  });
});

var showMore = function() {
  var showChar = 300;  // How many characters are shown by default
  var ellipsestext = "...";
  var moretext = "Read More";
  var lesstext = "Read Less";
  $('.more').each(function() {
    var content = $(this).html();
    if(content.length > showChar) {
      var c = content.substr(0, showChar);
      var h = content.substr(showChar, content.length - showChar);
      var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
      $(this).html(html);
    }
  });
};