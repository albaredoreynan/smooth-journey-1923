// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function startCalc(){
  interval = setInterval("calc()",1);
}

function calc(){
  one = document.new_categorysale.categorysale[csrows_attributes][0][cs_amount].value;
  two = document.new_categorysale.categorysale[csrows_attributes][1][cs_amount].value; 
  document.new_categorysale.categorysale[cs_total_amount].value = (one * 1) + (two * 1);
  
}

function stopCalc(){
  clearInterval(interval);
}

function remove_fields (link) {
	$(link).previous("input[type=hidden]").value = "1";
	$(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

/*function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).parent(".nested-fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}*/