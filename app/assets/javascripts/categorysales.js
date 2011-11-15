$(document).ready(function(){
  $('#shares').keyup(function(){
    $('#result').text($('#shares').val() * .12);
  });
});
