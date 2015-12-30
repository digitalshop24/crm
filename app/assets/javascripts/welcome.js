//= require jquery
//= require jquery_ujs
//= require moment
//= require moment/ru.js
//= require bootstrap-sprockets
//= require_tree .
//= require maskedinput
//= require bootstrap-datetimepicker

$(document).ready(function(){
    var counter = 2;
    $('#del_file').hide();
    $('img#add_file').click(function(){
        $('#file_tools').before('<div class="file_upload oneItem"><input type="text" class="form-control" placeholder="Прикрепить файлы" id="f'+counter+'" /><input type="file" name="materials[]" id="materials_" onchange="document.getElementById(\'f'+counter+'\').value = this.value;" /></div>');
        $('#del_file').fadeIn(0);
    counter++;
    });
    $('img#del_file').click(function(){
        if(counter==3){
            $('#del_file').hide();
        }   
        counter--;
        $('#f'+counter).remove();
    });
});

