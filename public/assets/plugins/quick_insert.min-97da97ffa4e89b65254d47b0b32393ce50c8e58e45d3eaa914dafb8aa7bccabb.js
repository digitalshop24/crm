/*!
 * froala_editor v2.1.0 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms
 * Copyright 2014-2016 Froala Labs
 */


!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof module&&module.exports?module.exports=function(b,c){return void 0===c&&(c="undefined"!=typeof window?require("jquery"):require("jquery")(b)),a(c),c}:a(jQuery)}(function(a){"use strict";a.extend(a.FroalaEditor.DEFAULTS,{quickInsertOffset:10,quickInsertButtons:["image","table","ul","ol","hr","paragraph"]}),a.FroalaEditor.QUICK_INSERT_BUTTONS={image:{icon:"insertImage",callback:function(b){a(b).after('<input accept="image/*" name="quickInsertImage'+this.id+'" style="display: none;" type="file">');var c=this;a(b).next().on("change",function(){if(this.files){var d=b.parentNode,e=d.parentNode;"OL"==e.tagName||"UL"==e.tagName?a(d).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>"):a(d).replaceWith("<p>"+a.FroalaEditor.MARKERS+"<br></p>"),c.quickInsert.hide(!0),c.selection.restore(),c.image.showInsertPopup();var f=c.popups.get("image.insert");c.position.forSelection(f),c.image.upload(this.files)}}),a(b).next().trigger("click")},requiredPlugin:"image",title:"Insert Image"},table:{icon:"insertTable",callback:function(b){var c=b.parentNode,d=c.parentNode;"OL"==d.tagName||"UL"==d.tagName?a(c).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>"):a(c).replaceWith("<p>"+a.FroalaEditor.MARKERS+"<br></p>"),this.quickInsert.hide(!0),this.selection.restore(),this.table.insert(2,2),this.undo.saveStep()},requiredPlugin:"table",title:"Insert Table"},ol:{icon:"formatOL",callback:function(b){var c=b.parentNode,d=c.parentNode;"OL"==d.tagName||"UL"==d.tagName?a(c).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>"):a(c).replaceWith("<p>"+a.FroalaEditor.MARKERS+"<br></p>"),this.quickInsert.hide(!0),this.selection.restore(),"UL"==d.tagName&&this.lists.format(d.tagName),"OL"!=d.tagName&&this.lists.format("OL"),this.undo.saveStep()},requiredPlugin:"lists",title:"Ordered List"},ul:{icon:"formatUL",callback:function(b){var c=b.parentNode,d=c.parentNode;"OL"==d.tagName||"UL"==d.tagName?a(c).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>"):a(c).replaceWith("<p>"+a.FroalaEditor.MARKERS+"<br></p>"),this.quickInsert.hide(!0),this.selection.restore(),"OL"==d.tagName&&this.lists.format(d.tagName),"UL"!=d.tagName&&this.lists.format("UL"),this.undo.saveStep()},requiredPlugin:"lists",title:"Unordered List"},hr:{icon:"insertHR",callback:function(b){var c=b.parentNode,d=c.parentNode;"OL"==d.tagName||"UL"==d.tagName?a(c).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>"):a(c).replaceWith("<p>"+a.FroalaEditor.MARKERS+"<br></p>"),this.quickInsert.hide(!0),this.selection.restore(),this.commands.insertHR(),this.undo.saveStep()},title:"Insert Horizontal Line"},paragraph:{icon:"paragraphFormat",callback:function(b){var c=b.parentNode,d=c.parentNode;if("OL"==d.tagName||"UL"==d.tagName)a(c).replaceWith("<li>"+a.FroalaEditor.MARKERS+"<br></li>");else{var e=this.html.defaultTag();e?a(c).replaceWith("<"+e+">"+a.FroalaEditor.MARKERS+"<br></"+e+">"):a(c).replaceWith(a.FroalaEditor.MARKERS+"<br>")}this.quickInsert.hide(!0),this.selection.restore(),this.undo.saveStep()},title:"Break"}},a.FroalaEditor.RegisterQuickInsertCommand=function(b,c){a.FroalaEditor.QUICK_INSERT_BUTTONS[b]=c},a.FroalaEditor.PLUGINS.quickInsert=function(b){function c(c,d){if(q&&!d&&n.hasClass("fr-visible"))return!1;var e,f,g,h;if(h=c.parent(),e=c.offset().top,g=h.outerWidth(),f=b.$box.offset().left,b.opts.iframe&&(e+=b.$iframe.offset().top-a(b.original_window).scrollTop()),e-=b.window.pageYOffset,f=f-b.window.pageXOffset-n.find("> a").outerWidth(),n.css("top",e),n.css("left",f),n.css("width",c.offset().left-f),n.css("height",2*Math.ceil(parseFloat(c.outerHeight())/2)),n.find("> a.fr-floating-btn").outerHeight()>c.outerHeight()||c.hasClass("fr-qi-helper")){var i=n.outerHeight();n.height(n.find("> a.fr-floating-btn").outerHeight()),n.css("top",e-(n.find("> a.fr-floating-btn").outerHeight()-i)/2)}n.data("tag",c),n.addClass("fr-visible")}function d(c){if(c){var d=a(c);if(0===b.$el.find(d).length)return g(),null;if(c.nodeType!=Node.TEXT_NODE&&b.node.isBlock(c)&&["TR","TH","TD","TBODY","THEAD","TABLE"].indexOf(c.tagName)<0)return d;if(b.node.blockParent(d.get(0)))return c=b.node.blockParent(d.get(0)),["TR","TH","TD","TBODY","THEAD","TABLE"].indexOf(c.tagName)>=0?(g(),!1):a(c)}return g(),null}function e(e){if(p=null,b.$tb.hasClass("fr-inline")&&b.$tb.is(":visible"))return!1;if(b.popups.areVisible())return!1;var f,h,i,j=null,k=b.document.elementFromPoint(e.pageX-b.window.pageXOffset,e.pageY-b.window.pageYOffset);if(b.node.isElement(k))for(f=1;f<=b.opts.quickInsertOffset;f++){if(h=b.document.elementFromPoint(e.pageX-b.window.pageXOffset,e.pageY-b.window.pageYOffset-f),h&&!b.node.isElement(h)&&h!=b.$wp.get(0)&&a(h).parents(b.$wp).length){j=d(h);break}if(i=b.document.elementFromPoint(e.pageX-b.window.pageXOffset,e.pageY-b.window.pageYOffset+f),i&&!b.node.isElement(i)&&i!=b.$wp.get(0)&&a(i).parents(b.$wp).length){j=d(i);break}}else j=d(k);if(j){var l=j.parent().get(0);["UL","OL"].indexOf(l.tagName)>=0&&(l=l.parentNode),e.pageX-b.window.pageXOffset-j.offset().left<j.outerWidth()/2&&l==b.$el.get(0)?c(j):g()}}function f(a){o===!1&&(p&&clearTimeout(p),p=setTimeout(e,30,a))}function g(a){return a&&(q=!1),q?!1:(p&&clearTimeout(p),b.html.checkIfEmpty(),void n.removeClass("fr-visible fr-on"))}function h(){o=!0,g()}function i(){o=!1}function j(d){if(d.preventDefault(),q)k();else{for(var e=n.data("tag"),f=b.opts.quickInsertButtons,g=b.node.isEmpty(e.get(0))&&["DIV","P"].indexOf(e.get(0).tagName)>=0,h='<div class="fr-qi-helper"'+(g?' data-fr-empty="'+e.get(0).outerHTML+'"':"")+">",i=0,j=0;j<f.length;j++){var l=a.FroalaEditor.QUICK_INSERT_BUTTONS[f[j]];l&&(!l.requiredPlugin||a.FroalaEditor.PLUGINS[l.requiredPlugin]&&b.opts.pluginsEnabled.indexOf(l.requiredPlugin)>=0)&&(h+='<a class="fr-btn" role="button" title="'+b.language.translate(l.title)+'" tabindex="-1" data-cmd="'+f[j]+'" style="transition-delay: '+.025*i++ +'s;">'+b.icon.create(l.icon)+"</a>")}h+="</div>",b.node.isEmpty(e.get(0))&&["DIV","P"].indexOf(e.get(0).tagName)>=0?e.replaceWith(h):e.before(h),setTimeout(function(){b.$el.find(".fr-qi-helper > a").addClass("fr-size-1"),c(b.$el.find(".fr-qi-helper")),n.addClass("fr-on"),q=!0},10)}}function k(){var a=b.$el.find(".fr-qi-helper");a.data("fr-empty")?a.replaceWith(a.data("fr-empty")):a.remove(),q=!1,g()}function l(){n=a('<div class="fr-quick-insert"><a class="fr-floating-btn" role="button" tabindex="-1" title="'+b.language.translate("Break")+'"><svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><path d="M22,16.75 L16.75,16.75 L16.75,22 L15.25,22.000 L15.25,16.75 L10,16.75 L10,15.25 L15.25,15.25 L15.25,10 L16.75,10 L16.75,15.25 L22,15.25 L22,16.75 Z"/></svg></a></div>'),b.$box.append(n),b.events.on("destroy",function(){n.html("").removeData().remove()},!0),b.events.on("focus",k,!0),b.events.on("window.mousedown",k,!0),b.events.on("commands.before",k,!0),n.on("mousemove",function(a){a.stopPropagation()}),n.on("mousedown","a",function(a){a.stopPropagation()}),n.on("click","a",j),b.events.bindClick(b.$el,".fr-qi-helper > a.fr-btn",function(c){var d=a(c.currentTarget).data("cmd");a.FroalaEditor.QUICK_INSERT_BUTTONS[d].callback.apply(b,[c.currentTarget])}),b.tooltip.bind(b.$el,".fr-qi-helper > a.fr-btn"),b.events.on("destroy",function(){n.off("mouseleave.quickInsert"),n.off("mousedown"),n.off("mousedown","a"),n.off("click","a")},!0)}function m(){return b.$wp?(b.opts.iframe&&b.$el.parent("html").find("head").append('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">'),l(),o=!1,b.$window.on("mousemove.quickInsert"+b.id,f),a(b.window).on("scroll.quickInsert"+b.id,function(){q?c(b.$el.find(".fr-qi-helper"),!0):g()}),a(b.window).on("mousedown.quickInsert"+b.id,h),a(b.window).on("mouseup.quickInsert"+b.id,i),b.events.on("html.get",function(a){return a=a.replace(/<(div)((?:[\w\W]*?))class="([\w\W]*?)fr-qi-helper([\w\W]*?)"((?:[\w\W]*?))>((?:[\w\W]*?))<\/(div)>/g,"")}),void b.events.on("destroy",function(){b.$window.off("mousemove.quickInsert"+b.id),a(b.window).off("scroll.quickInsert"+b.id),a(b.window).off("mousedown.quickInsert"+b.id),a(b.window).off("mouseup.quickInsert"+b.id)},!0)):!1}var n,o,p,q=!1;return{_init:m,hide:g}}});