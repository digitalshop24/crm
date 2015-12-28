//= require jquery
//= require jquery_ujs
//= require turbolinks
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
        $('#file_tools').before('<div class="file_upload oneItem"><input type="text" class="form-control" placeholder="Прикрепить файлы" id="f'+counter+'" /><div class="imgPort"><img class="text-right img-resonsive" src="/assets/download-6c71f202bfc944e0be652d95a45787163d9f8f54ea79088dbb743bbfe868f37b.png" alt="Download 6c71f202bfc944e0be652d95a45787163d9f8f54ea79088dbb743bbfe868f37b"></div><input type="file" name="materials[]" id="materials_" onchange="document.getElementById(\'f'+counter+'\').value = this.value;" /></div>');
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

