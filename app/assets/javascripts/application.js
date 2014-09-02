// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require cocoon
//= require turbolinks
//= require bootstrap
jQuery( function($) {
    $('a').tooltip();
});

jQuery( function($) {
    $('abbr').tooltip();
});
//= require_tree .
$(document).ready(function() {
  $("#parent a.add_fields").
    data("association-insertion-position", 'before').
    data("association-insertion-node", 'this');

  $('#parent').bind('cocoon:after-insert',
     function() {
       $("#parent_from_list").hide();
       $("#parent a.add_fields").hide();
     });
  $('#parent').bind("cocoon:after-remove",
     function() {
       $("#parent_from_list").show();
       $("#parent a.add_fields").show();
     });
});