//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.16.custom.min.js
$(function() {
  $('.datepicker').datepicker({dateFormat: 'yy-mm-dd'})
});

$(function(){
  $( "#dialog:ui-dialog" ).dialog( "destroy" );

  $("#add_new_item").click(function() {
    $("#dialog_item").dialog( "open" );
  });

  $( "#dialog_item" ).dialog({
    autoOpen: false,
    height: 'auto',
    width: 500,
    modal: true,
  });
});
