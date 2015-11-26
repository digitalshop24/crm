var ready;
ready = function() {

    $("#user_role").change(function() {
        $(".hiddenable").addClass("hidden");
        $("." + $(this).val()).removeClass("hidden");
    });

    $(".mobile-phone").mask("+999 (99) 999 99 99");
    $(".datepicker").mask("99.99.9999");
    $('.datetimepicker').datetimepicker({
        minDate: "01/01/2015",
        maxDate: "01/01/2020",
        stepping: 10,
        sideBySide: true
    });
    $('.datepicker').datetimepicker({
        minDate: "01/01/2015",
        maxDate: "01/01/2020",
        widgetPositioning: { vertical: 'top'}
    });
    $('select.oneItem').niceSelect();

};

$(document).ready(ready);
$(document).on('page:load', ready)
