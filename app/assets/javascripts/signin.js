$(document).ready(function(){
$(".sign_in").click(function()
        {
        $("#sign_box").show();
        return false;
        });

$("body").click(function()
{
        $("#sign_box").hide();
        return false;
});
});