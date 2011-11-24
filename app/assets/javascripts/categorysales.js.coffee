$(document).ready ->
  $("#shares").keyup ->
    $("#result").text $("#shares").val() * .12