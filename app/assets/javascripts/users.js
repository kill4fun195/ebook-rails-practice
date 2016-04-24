$(document).ready(function(){
  $("#new-user").validate({
    
        // Specify the validation rules
        rules: {
            "user[name_user]": {
              required: true,
              minlength:5
            },
            "user[email]": {
                required: true,
                email: true
            },
            "user[password]": {
                required: true,
                minlength: 3
            }
        }
        
    });
});
