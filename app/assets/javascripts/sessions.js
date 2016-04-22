$(document).ready(function(){
  $(".notice").hide();
  $("body").on("click",".modal-content #new_user .loggin-account input",function(event){
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
