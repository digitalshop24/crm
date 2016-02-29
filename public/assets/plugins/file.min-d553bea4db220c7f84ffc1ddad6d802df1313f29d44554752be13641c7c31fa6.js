/*!
 * froala_editor v2.1.0 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms
 * Copyright 2014-2016 Froala Labs
 */


!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof module&&module.exports?module.exports=function(b,c){return void 0===c&&(c="undefined"!=typeof window?require("jquery"):require("jquery")(b)),a(c),c}:a(jQuery)}(function(a){"use strict";a.extend(a.FroalaEditor.POPUP_TEMPLATES,{"file.insert":"[_BUTTONS_][_UPLOAD_LAYER_][_PROGRESS_BAR_]"}),a.extend(a.FroalaEditor.DEFAULTS,{fileUploadURL:"http://i.froala.com/upload",fileUploadParam:"file",fileUploadParams:{},fileUploadToS3:!1,fileUploadMethod:"POST",fileMaxSize:10485760,fileAllowedTypes:["*"],fileInsertButtons:["fileBack","|"],fileUseSelectedText:!1}),a.FroalaEditor.PLUGINS.file=function(b){function c(){var a=b.$tb.find('.fr-command[data-cmd="insertFile"]'),c=b.popups.get("file.insert");if(c||(c=r()),e(),!c.hasClass("fr-active")){b.popups.refresh("file.insert"),b.popups.setContainer("file.insert",b.$tb);var d=a.offset().left+a.outerWidth()/2,f=a.offset().top+(b.opts.toolbarBottom?0:a.outerHeight());b.popups.show("file.insert",d,f,a.outerHeight())}}function d(){var a=b.popups.get("file.insert");a&&(a.find(".fr-layer.fr-active").removeClass("fr-active").addClass("fr-pactive"),a.find(".fr-file-progress-bar-layer").addClass("fr-active"),a.find(".fr-buttons").hide(),f("Uploading",0))}function e(a){var c=b.popups.get("file.insert");c&&(c.find(".fr-layer.fr-pactive").addClass("fr-active").removeClass("fr-pactive"),c.find(".fr-file-progress-bar-layer").removeClass("fr-active"),c.find(".fr-buttons").show(),a&&b.popups.show("file.insert",null,null))}function f(a,c){var d=b.popups.get("file.insert");if(d){var e=d.find(".fr-file-progress-bar-layer");e.find("h3").text(a+(c?" "+c+"%":"")),e.removeClass("fr-error"),c?(e.find("div").removeClass("fr-indeterminate"),e.find("div > span").css("width",c+"%")):e.find("div").addClass("fr-indeterminate")}}function g(a){var c=b.popups.get("file.insert"),d=c.find(".fr-file-progress-bar-layer");d.addClass("fr-error"),d.find("h3").text(a)}function h(a,c,d){b.edit.on(),b.events.focus(!0),b.selection.restore(),b.html.insert('<a href="'+a+'" id="fr-inserted-file" class="fr-file">'+(c||b.selection.text())+"</a>");var e=b.$el.find("#fr-inserted-file");e.removeAttr("id"),b.popups.hide("file.insert"),b.undo.saveStep(),b.events.trigger("file.inserted",[e,d])}function i(c){try{if(b.events.trigger("file.uploaded",[c],!0)===!1)return b.edit.on(),!1;var d=a.parseJSON(c);return d.link?d:(n(x,c),!1)}catch(e){return n(z,c),!1}}function j(c){try{var d=a(c).find("Location").text(),e=a(c).find("Key").text();return b.events.trigger("file.uploadedToS3",[d,e,c],!0)===!1?(b.edit.on(),!1):d}catch(f){return n(z,c),!1}}function k(a){var c=this.status,d=this.response,e=this.responseXML,f=this.responseText;try{if(b.opts.fileUploadToS3)if(201==c){var g=j(e);g&&h(g,a,d||e)}else n(z,d||e);else if(c>=200&&300>c){var k=i(f);k&&h(k.link,a,d||f)}else n(y,d||f)}catch(l){n(z,d||f)}}function l(){n(z,this.response||this.responseText||this.responseXML)}function m(a){if(a.lengthComputable){var b=a.loaded/a.total*100|0;f("Uploading",b)}}function n(a,c){b.edit.on(),g(b.language.translate("Something went wrong. Please try again.")),b.events.trigger("file.error",[{code:a,message:D[a]},c])}function o(a){if(b.events.trigger("file.beforeUpload",[a])===!1)return!1;if("undefined"!=typeof a&&a.length>0){var c=a[0];if(c.size>b.opts.fileMaxSize)return n(A),!1;if(b.opts.fileAllowedTypes.indexOf("*")<0&&b.opts.fileAllowedTypes.indexOf(c.type.replace(/file\//g,""))<0)return n(B),!1;var e;if(b.drag_support.formdata&&(e=b.drag_support.formdata?new FormData:null),e){var f;if(b.opts.fileUploadToS3!==!1){e.append("key",b.opts.fileUploadToS3.keyStart+(new Date).getTime()+"-"+(c.name||"untitled")),e.append("success_action_status","201"),e.append("X-Requested-With","xhr"),e.append("Content-Type",c.type);for(f in b.opts.fileUploadToS3.params)e.append(f,b.opts.fileUploadToS3.params[f])}for(f in b.opts.fileUploadParams)e.append(f,b.opts.fileUploadParams[f]);e.append(b.opts.fileUploadParam,c);var g=b.opts.fileUploadURL;b.opts.fileUploadToS3&&(g="https://"+b.opts.fileUploadToS3.region+".amazonaws.com/"+b.opts.fileUploadToS3.bucket);var h=b.core.getXHR(g,b.opts.fileUploadMethod);h.onload=function(){k.call(h,[b.opts.fileUseSelectedText?null:c.name])},h.onerror=l,h.upload.onprogress=m,d(),b.edit.off(),h.send(e)}}}function p(b){b.on("dragover dragenter",".fr-file-upload-layer",function(){return a(this).addClass("fr-drop"),!1}),b.on("dragleave dragend",".fr-file-upload-layer",function(){return a(this).removeClass("fr-drop"),!1}),b.on("drop",".fr-file-upload-layer",function(b){b.preventDefault(),b.stopPropagation(),a(this).removeClass("fr-drop");var c=b.originalEvent.dataTransfer;c&&c.files&&o(c.files)}),b.on("change",'.fr-file-upload-layer input[type="file"]',function(){this.files&&o(this.files),a(this).val("")})}function q(){e()}function r(){var a="";a='<div class="fr-buttons">'+b.button.buildList(b.opts.fileInsertButtons)+"</div>";var c="";c='<div class="fr-file-upload-layer fr-layer fr-active" id="fr-file-upload-layer-'+b.id+'"><strong>'+b.language.translate("Drop file")+"</strong><br>("+b.language.translate("or click")+')<div class="fr-form"><input type="file" name="'+b.opts.fileUploadParam+'" accept="/*" tabIndex="-1"></div></div>';var d='<div class="fr-file-progress-bar-layer fr-layer"><h3 class="fr-message">Uploading</h3><div class="fr-loader"><span class="fr-progress"></span></div><div class="fr-action-buttons"><button type="button" class="fr-command" data-cmd="fileDismissError" tabIndex="2">OK</button></div></div>',e={buttons:a,upload_layer:c,progress_bar:d},f=b.popups.create("file.insert",e);return b.popups.onHide("file.insert",q),p(f),f}function s(c){return a(c).hasClass("fr-file")?b.events.trigger("file.unlink",[c]):void 0}function t(){var c=function(a){a.preventDefault()};b.events.on("dragenter",c),b.events.on("dragover",c),b.events.on("drop",function(c){b.popups.hideAll();var e=c.originalEvent.dataTransfer;if(e&&e.files&&e.files.length){var f=e.files[0];if(f&&"undefined"!=typeof f.type&&(b.opts.fileAllowedTypes.indexOf(f.type)>=0||b.opts.fileAllowedTypes.indexOf("*")>=0)){b.markers.remove(),b.markers.insertAtPoint(c.originalEvent),b.$el.find(".fr-marker").replaceWith(a.FroalaEditor.MARKERS),b.popups.hideAll();var g=b.popups.get("file.insert");g||(g=r()),b.popups.setContainer("file.insert",a(b.opts.scrollableContainer)),b.popups.show("file.insert",c.originalEvent.pageX,c.originalEvent.pageY),d(),o(e.files),c.preventDefault(),c.stopPropagation()}}})}function u(){b.events.disableBlur(),b.selection.restore(),b.events.enableBlur(),b.popups.hide("file.insert"),b.toolbar.showInline()}function v(){t(),b.events.on("link.beforeRemove",s)}var w=1,x=2,y=3,z=4,A=5,B=6,C=7,D={};return D[w]="File cannot be loaded from the passed link.",D[x]="No link in upload response.",D[y]="Error during file upload.",D[z]="Parsing response failed.",D[A]="File is too large.",D[B]="File file type is invalid.",D[C]="Files can be uploaded only to same domain in IE 8 and IE 9.",{_init:v,showInsertPopup:c,upload:o,insert:h,back:u,hideProgressBar:e}},a.FroalaEditor.DefineIcon("insertFile",{NAME:"file-o"}),a.FroalaEditor.RegisterCommand("insertFile",{title:"Upload File",undo:!1,focus:!0,refershAfterCallback:!1,popup:!0,callback:function(){this.popups.isVisible("file.insert")?(this.$el.find(".fr-marker")&&(this.events.disableBlur(),this.selection.restore()),this.popups.hide("file.insert")):this.file.showInsertPopup()},plugin:"file"}),a.FroalaEditor.DefineIcon("fileBack",{NAME:"arrow-left"}),a.FroalaEditor.RegisterCommand("fileBack",{title:"Back",undo:!1,focus:!1,back:!0,refreshAfterCallback:!1,callback:function(){this.file.back()},refresh:function(a){this.opts.toolbarInline?(a.removeClass("fr-hidden"),a.next(".fr-separator").removeClass("fr-hidden")):(a.addClass("fr-hidden"),a.next(".fr-separator").addClass("fr-hidden"))}}),a.FroalaEditor.RegisterCommand("fileDismissError",{title:"OK",callback:function(){this.file.hideProgressBar(!0)}})});
