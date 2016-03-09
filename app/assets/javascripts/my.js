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

    $('.set_receiver').click(function(){
        var receiver = { 'id': $(this).attr('data-receiver'), 'name': $(this).attr('data-receiver-name')};
        $('input#message_receiver_id').val(receiver['id']);
        $('#receiver_id_show span').html(receiver['name']);
        $('#receiver_id_show, .send_button_main').removeClass('hidden');
        $('html, body').animate({
          scrollTop: $("#message_form").offset().top
        }, 1000);
    });

    $('.send_button').click(function(){
      $('input#message_receiver_id').val($(this).attr('data-receiver'));
      $('#receiver_id_show, .send_button_main').addClass('hidden');
    }); 
});

//$(document).ready(ready);
//$(document).on('page:load', ready)
