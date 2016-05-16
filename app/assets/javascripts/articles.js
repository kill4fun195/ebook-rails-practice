$(document).ready(function(){  
  $(".navbar  .search .toggle-search").click(function(){
    $(".form-search").toggle();
    $(".navbar  .search .form-search form input").focus();
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
          body: tinyMCE.activeEditor.getContent()
        }
      },
      success: function(response) {
        comments = $("<div></div>").append(response).find(".comment-show-article");
        $("body .comment-show-article").html(comments.html());
        _this.removeAttr("disabled");
        _this.removeClass("loading");
        tinyMCE.activeEditor.setContent('');
      }
    });
    return false;
  });

  $("body").on('click', ".comment-show-article .paging li a", function(e){
    var i = Number($(this).text().trim());

    $.ajax({ 
      url: window.location.href+"?page="+ i,
      success: function(response) {
        comments = $("<div></div>").append(response).find(".comment-show-article");
        $("body .comment-show-article").html(comments.html());
      }
    });
    return false;
  });
  $(".article .body-right-article .content-body-right-article").each(function(index){
    if($(this).text().length > 200 )
    {
      content = $(this).html();
      $(this).html(content.substring(0,200) + "..." +
         "<a href = '#' class = 'read-more'>read more</a>");
    
      $(".body-right-article ").on("click", ".read-more", function(){
        $(this).parents(".body-right-article p").html(content +"..." + " <a href = '#' class = 'read-less'>read less </a>");
        return false;
      });
      $(".body-right-article ").on("click", ".read-less", function(){
       $(this).parents(".body-right-article p").html(content.substring(0,200)+"..." + "<a href = '#' class = 'read-more'>read more</a>");
        return false;
      });
    }
  });
  
  $(".description-article").each(function(){
      content = $(this).html();
      $(this).html(content.substring(0,200) + "...");
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
