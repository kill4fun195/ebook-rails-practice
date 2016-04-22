$(document).ready(function(){
  $(".notice").hide();
  $(".no-login-article p a").click(function(){
    $("#user_email").val("");
    $("#user_password").val("");
  })
  $("body").on("click",".modal-content form #loggin-account ",function(event){
    form = $(this).parents("form");
      $.ajax({
          url: form.attr("action"),
          type: "POST",
      data: {"user": {
          email: $("#user_email").val(),
          password: $("#user_password").val()
        }
      },
      success: function(response) {
        if($(response).find(".notice").text()=="invalid")
        {
          alert("dang nhap sai");
        }
        if($(response).find(".notice").text()=="logged")
        {
          alert("dang nhap thanh cong");
          window.location = window.location
        }
      }
      });
      return false;
  });
});
