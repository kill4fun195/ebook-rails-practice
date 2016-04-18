$(document).ready(function(){
    $("#letter-a a").click(function(){
      $.ajax({
        url: "/sessions",
        type: "POST",
        dataType: "html",
         beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
        data: {user: {email: "admin", password: "123"}},
        success: function(response) {
          $("#dictionary").html("asdasdasd");
        }
      })
        
       return false;
    });
    $('#letter-b a').click(function() { 
    $.getJSON('b.json', function(data) { 
        $('#dictionary').empty(); 
        $.each(data, function(entryIndex, entry) { 
          var html = '<div class="entry">'; 
          html += '<h3 class="term">' + entry['term'] + '</h3>'; 
          html += '<div class="part">' + entry['part'] + '</div>'; 
          html += '<div class="definition">'; 
          html += entry['definition']; 
          if (entry['quote']) { 
          html += '<div class="quote">'; 
          $.each(entry['quote'], function(lineIndex, line) { 
          html += '<div class="quote-line">' + line + '</div>';
          }); 
          if (entry['author']) { 
          html += '<div class="quote-author">' + entry['author'] + '</div>'; 
          } 
          html += '</div>'; 
          } 
          html += '</div>'; 
          html += '</div>'; 
          $('#dictionary').append(html); 
          }); 
        }); 
        return false; 
    });
    $('#letter-c a').click(function() { 
      $.getScript('c.js'); 
      return false; 
    });

});
