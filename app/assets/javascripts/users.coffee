$ ->
  $(document).on 'change', '.speciality_select', (evt) ->
    $.ajax '/admin/users/update_specialities',
      type: 'GET'
      dataType: 'script'
      data: {
        speciality_id: $(this).find("option:selected").val(),
        speciality_number: $(this).parents('.row').attr('id')
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")


