# // application.js
# // Place your application-specific JavaScript functions and classes here
# // This file is automatically included by javascript_include_tag :defaults

startCalc = ->
  interval = setInterval("calc()",1)

calc = ->
  one = document.new_categorysale.categorysale[category_sales_attributes][0][amount].val()
  two = document.new_categorysale.categorysale[category_sales_attributes][1][amount].val()
  document.new_categorysale.categorysale[cs_total_amount].val((one * 1) + (two * 1))

stopCalc = ->
  clearInterval(interval)

remove_fields = (link) ->
  $(link).previous("input[type=hidden]").val("1")
  $(link).up(".fields").hide()

add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).up().insert before: content.replace(regexp, new_id)


# /*function remove_fields(link) {
  # $(link).prev("input[type=hidden]").val("1");
  # $(link).parent(".nested-fields").hide();
# }
# 
# function add_fields(link, association, content) {
  # var new_id = new Date().getTime();
  # var regexp = new RegExp("new_" + association, "g")
  # $(link).parent().before(content.replace(regexp, new_id));
# }*/
