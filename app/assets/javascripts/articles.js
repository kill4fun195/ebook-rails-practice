$(document).ready(function(){  
  $(".navbar  .search .toggle-search").click(function(){
    $(".form-search").toggle();
    $(".navbar  .search .form-search form input").focus();
  })
  $(".after-login-frontend #toogle-user-info").click(function(){
    $(".toogle-user-info").toggle();
  })
  $('#scroll').click(function(){ 
        $("html, body").animate({ scrollTop: 0 }, 1000); 
        return false; 
  }); 

  $("div.login-article form input[type='submit']").click(function(e){
    form = $(this).parents("form");
    _this = $(this);
    _this.attr("disabled", true);
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
        tinyMCE.activeEditor.setContent('');
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
