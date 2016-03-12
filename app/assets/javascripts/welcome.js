//= require jquery-1.11.2.min
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require bootstrap.min
//= require owl.carousel.min
//= require jquery.formstyler.min
//= require moment-with-locales.min
//= require bootstrap-datetimepicker.min
//= require engine
//= require froala_editor.min.js
//= require plugins/save.min.js
//= require plugins/align.min.js
//= require plugins/char_counter.min.js
//= require plugins/code_beautifier.min.js
//= require plugins/code_view.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require plugins/colors.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/fullscreen.min.js
//= require plugins/inline_style.min.js
//= require plugins/line_breaker.min.js
//= require plugins/link.min.js
//= require plugins/lists.min.js
//= require plugins/paragraph_format.min.js
//= require plugins/paragraph_style.min.js
//= require plugins/quote.min.js
//= require plugins/save.min.js
//= require plugins/table.min.js
//= require plugins/url.min.js
//= require languages/ru.js
//= require users
//= require placeholders.min
//= require modernizr
//= require jquery.mask.js

$(document).ready(function(){
    $(".mobile-phone").mask("+999 (99) 999 99 99");
    var counter = 2;
    $('#del_file').hide();
    $('img#add_file').click(function(){
        $('#file_tools').before('<div class="file_upload"><input type="text" class="form-control" placeholder="Прикрепить файлы" id="f'+counter+'" /><input type="file" name="materials[]" id="materials_" onchange="document.getElementById(\'f'+counter+'\').value = this.value;" /></div>');
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

$(document).ready(ready);
$(document).on('page:load', ready)

