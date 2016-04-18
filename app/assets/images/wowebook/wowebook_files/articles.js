
$(document).ready(function(){
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
        comments = $("<div></div>").append(response).find(".comment-article");
        $("body .comment-article").html(comments.html());
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
$("body .sidebar-right .content-mid-sidebar-right-2").hide();
     $("body .sidebar-right .content-mid-sidebar-right-3").hide();
  $("body .sidebar-right .popular-post").click(function(){
    $("body .sidebar-right .content-mid-sidebar-right-1").show(10);
    $("body .sidebar-right .content-mid-sidebar-right-2").hide();
     $("body .sidebar-right .content-mid-sidebar-right-3").hide("slow");
    return false;
  });
  $("body .sidebar-right .recent-post").click(function(){
    $("body .sidebar-right .content-mid-sidebar-right-2").show(10);
    $("body .sidebar-right .content-mid-sidebar-right-1").hide();
     $("body .sidebar-right .content-mid-sidebar-right-3").hide("slow");
    return false;
  });
  $("body .sidebar-right .recent-comment").click(function(){
    $("body .sidebar-right .content-mid-sidebar-right-1").hide();
    $("body .sidebar-right .content-mid-sidebar-right-2").hide();
    $("body .sidebar-right .content-mid-sidebar-right-3").show(10);
    return false;
  });
  $(".border-content-mid-sidebar-right ").each(function(){
    if $(".border-content-mid-sidebar-right ").hover
    {
      alert("Asd");
    }
  })
   
  });
  
});
