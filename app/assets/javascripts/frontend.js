$(document).ready(function(){  
  $("#sidebar-left-toggle-left").click( function(){
    $(".sidebar-left-toggle-left").css("display","none");
    $(".sidebar-left-toggle-right").css("display","block");
    });

  $("#sidebar-left-toggle-right").click( function(){
    $(".sidebar-left-toggle-left").css("display","block");
    $(".sidebar-left-toggle-right").css("display","none");
  });

  $("#sidebar-right-toggle-left").click( function(){
    $(".sidebar-right-toggle-left").css("display","none");
    $(".sidebar-right-toggle-right").css("display","block");
  });

  $("#sidebar-right-toggle-right").click( function(){
    $(".sidebar-right-toggle-left").css("display","block");
    $(".sidebar-right-toggle-right").css("display","none");
    $(".sidebar-left-toggle-right").css("display","none");
    $(".sidebar-left-toggle-left").css("display","block");
  });

  $("#sidebar-left-toggle-left1").click( function(){
    $(".sidebar-left-toggle-left1").css("display","none");
    $(".sidebar-left-toggle-right1").css("display","block");
  });
  $("#sidebar-left-toggle-right1").click( function(){
    $(".sidebar-left-toggle-left1").css("display","block");
    $(".sidebar-left-toggle-right1").css("display","none");
  });

  var articles = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/articles.json?query=%QUERY',
      wildcard: '%QUERY'
    }
  });

  $('#the-basics .typeahead').typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      source: articles
    }
  );

});

