$(document).ready(function(){  
  $(".navbar  .col-sm-3 .toggle-search").click(function(){
    $(".form-search").toggle();
    $(".navbar  .col-sm-3 .form-search form input").focus();
  })
  $('#scroll').click(function(){ 
        $("html, body").animate({ scrollTop: 0 }, 1000); 
        return false; 
    }); 
   var current_page_URL = location.href;
  $( "a" ).each(function() {
     if ($(this).attr("href") !== "#") {
       var target_URL = $(this).prop("href");
       if (target_URL == current_page_URL) {
          $('.pagination a').parents('li').removeClass('active');
          $(this).parent('li').addClass('active');
          return false;
       }
     }
  });
  $("div.login-article form input[type='submit']").click(function(e){
    form = $(this).parents("form");
    _this = $(this);
    _this.attr("disabled", true);
    _this.addClass("loading");
    $.ajax({  
      url: form.attr("action"),
      type: "POST",
      data: {"comment": {
          body: $("#comment_body").val()
        }
      },
      success: function(response) {
        comments = $("<div></div>").append(response).find(".comment-show-article");
        $("body .comment-show-article").html(comments.html());
        _this.removeAttr("disabled");
        _this.removeClass("loading");
        $("#comment_body").val("");
      }
    });
    return false;
  });
  $(".article .body-right-article p").each(function(index){
    if($(this).text().length > 200 )
    {
      content = $(this).html();
      $(this).html(content.substring(0,200) + "..." +
         "<a href = '#' class = 'read-more'>read more</a>");
    
      $(".body-right-article p").on("click", ".read-more", function(){
        $(this).parents(".body-right-article p").html(content +"..." + " <a href = '#' class = 'read-less'>read less </a>");
        return false;
      });
      $(".body-right-article p").on("click", ".read-less", function(){
       $(this).parents(".body-right-article p").html(content.substring(0,200)+"..." + "<a href = '#' class = 'read-more'>read more</a>");
        return false;
      });
    }
  });
   $('.bxslider').bxSlider({
  minSlides: 4,
  maxSlides: 4,
  slideWidth: 360,
  slideMargin: 10
  });
   $('ul.nav li.dropdown').hover(function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
  }, function() {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
  }); 
});
