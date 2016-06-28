$(document).ready(function() {
    // Setup - add a text input to each footer cell
     $('#comments-table').dataTable({
        "processing": true,
        "serverSide": true,
        "ajax": $('#comments-table').data('source'),
        "pagingType": "full_numbers",
        // optional, if you want full pagination controls.
        // Check dataTables documentation to learn more about
        // available options.
      });
    $("body").on('click', ".modal-show", function(e){
        var a,b,id,url;
        id = $(this).attr("id");
        a = id.split("-");
        b = parseInt(a[2]);
        url = "http://localhost:3000/backend/comments/"+b;
        $.get(url,function(response){
            comment_show = $("<div></div>").append(response).find("#backend-comment-show");
            $(".content-myModalShow").html(comment_show.html());  
        })
    });
    $("body").on('click', ".modal-edit", function(e,index){
        var a,b,id,url;
        this_body = $(this).parents("tr").find("td:eq(1)");
        this_title = $(this).parents("tr").find("td:eq(3)");
        id = $(this).attr("id");
        a = id.split("-");
        b = parseInt(a[2]);
        url = "http://localhost:3000/backend/comments/"+b+"/edit";
        tinymce.editors = [];
        $.get(url,function(response){
            comment_edit = $("<div></div>").append(response).find("#backend-comment-edit");
            $(".content-myModalEdit").html(comment_edit.html());
            tinymce.init({ selector:'textarea' , menubar: false });
        
          $(".content-myModalEdit form input[type='submit']").click(function(){
            form = $(this).parents("form");
            $.ajax({
                url: form.attr("action") + ".json",
                type: "PUT",
                data: {"comment":{
                        body: tinyMCE.activeEditor.getContent(),
                        article_id: parseInt($("#comment_article_id").val())
                    }
                },
                success: function(response){
                     this_body.html(response.comment["body"]);
                     this_title.html(response.comment.article["title"]);
                     $("#myModalEdit .modal-header .close").click();
                }

            });
            return false;
          });
        });

    });

} );
