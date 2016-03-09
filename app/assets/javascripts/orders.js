var ready;
ready = function() {
    if ($("#order_worktype_id").val() != '') {
        $("#worktype_other").addClass("hidden")
    }

    if ($("#order_speciality_id").val() != '') {
        $("#speciality_other").addClass("hidden")
    }

    $("#order_worktype_id").change(function() {
        $("#worktype_other").removeClass("hidden");
        if ($(this).val() != '') {
            $("#worktype_other").addClass("hidden");
        }
    });

    $("#order_speciality_id").change(function() {
        $("#speciality_other").removeClass("hidden");
        if ($(this).val() != '') {
            $("#speciality_other").addClass("hidden");
        }
    });    
};

$(document).ready(ready);
$(document).on('page:load', ready)





