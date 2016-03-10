//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require moment
//= require moment/ru.js
//= require maskedinput
//= require jquery.nice-select.min
//= require my
//= require users
//= require bootstrap-datetimepicker
//= require faye

$(function() {
  $('body').on("click", "#users th a, #users .pagination a", function() {
    $.getScript(this.href);
    return false;
  });
  // $("#users_search input").keyup(function() {
  //   $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
  //   return false;
  // });

});

$(function() {
  $(".filter_search").find('input,select').on('keyup datechange change', function() {
    $.get($(".filter_search").attr("action"), $(".filter_search").serialize(), null, "script");
    return false;
  });
});


// $(function() {
//   $(".filter_select select").on('change', function() {
//     $.get($(".filter_search").attr("action"), $(".filter_search").serialize(), null, "script");
//     return false;
//   });
// });


var ready;
ready = function() {
  $('body').on("click", '#users_tabs li', function(e) {
      $(this).tab('show');
      var role = $(this).attr('role');
      $('#users_search #role').val(role);
      $('#users_search .warning input').val('');
    });  
  };
$(document).ready(ready);
$(document).on('page:load', ready)
