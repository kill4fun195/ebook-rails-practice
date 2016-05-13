$(document).ready(function(){  
 $('input[name="grid_articles_grid[created_at]"]').daterangepicker().val("");
 $('input[name="grid_comments_grid[created_at]"]').daterangepicker().val("");
 $('#grid_users_grid_role').append('<option value=""  hidden  selected="selected">Choose role</option>');
 
})
