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