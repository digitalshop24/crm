//= require jquery
//= require jquery_ujs
//= require moment
//= require moment/ru.js
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker
//= require maskedinput
//= require faye
//= require_tree .

$(function() {
  $('body').on("click", "#users th a, #users .pagination a", function() {
    $.getScript(this.href);
    return false;
  });
  $("#users_search input").keyup(function() {
    $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
    return false;
  });

});

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



