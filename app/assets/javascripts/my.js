var ready;
$(document).ready(function() {
    role = $("#user_role");

    role.change(function() {
      $(".hiddenable").addClass("hidden");
      $("." + $(this).val()).removeClass("hidden");
    });

    if(role.val() != '') {
       $(".hiddenable").addClass("hidden");
       $("." + role.val()).removeClass("hidden");
    }

    $('body').on('click', '.delete_speciality', function(){
        $(this).parents('.row').remove();
    });

    $(".mobile-phone").mask("+99999999999?9");
    $(".datepicker").mask("99.99.9999");
    $('.datetimepicker').datetimepicker({
        minDate: "01/01/2015",
        maxDate: "01/01/2020",
        stepping: 10,
        sideBySide: true
    });
    $('.new_order').find('.datepicker').datetimepicker({
        minDate: "01/01/2015",
        maxDate: "01/01/2020",
        widgetPositioning: { vertical: 'top'}
    });
    $('.filter_search').find('.datepicker').datetimepicker({
        minDate: "01/01/2015",
        maxDate: "01/01/2020",
        useCurrent: false,
        showClear: true
    });
    $('.datepicker, .datetimepicker').on('dp.change', function(e) {
        $(this).find('input').trigger('datechange');
    });
    $('select.oneItem').niceSelect();   
    $('#messages.panel-scroll').scrollTop(999999);
});

//$(document).ready(ready);
//$(document).on('page:load', ready)
