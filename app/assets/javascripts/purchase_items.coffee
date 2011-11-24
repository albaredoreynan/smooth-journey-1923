jQuery ->
  $('.updates_vat_amount').change ->
    $('#vat_amount').val(updateVatAmount()[0])
    $('#net_amount').val(updateVatAmount()[1])
    $("#paP").innerHTML = $('#purchase_item_amount').val()
    $("#vaP").innerHTML = $('#vat_amount').val(updateVatAmount()[0])
    $("#naP").innerHTML = $('#net_amount').val(updateVatAmount()[1])
    $("ucP").innerHTML = $('#purchase_item_unit_cost').val()
    $("pqP").innerHTML = $('#purchase_item_amount').val()
  
updateVatAmount = ->
  purchaseAmount = $('#purchase_item_amount')
  vatAmount = 0
  netAmount = 0
  
  if purchaseAmount.val() == ""
    
  else
    checkVat = ->
      if $('#purchase_item_vat_type_vat-inclusive').is(':checked')
        vatAmount = purchaseAmount.val() / 1.12
        vatAmount = purchaseAmount.val() - vatAmount
        netAmount = purchaseAmount.val() - vatAmount
        #vatAmount = purchaseAmount.value * (3/28)

      if $('#purchase_item_vat_type_vat-exclusive').is(':checked')
        vatAmount = purchaseAmount.val() * .12
        netAmount = purchaseAmount.val()
        
      if $('#purchase_item_vat_type_vat-exempted').is(':checked')
        vatAmount = 0
        netAmount = purchaseAmount.val()
        
    checkVat()
    @totalVat = vatAmount
    @totalNet = netAmount
    [@totalVat, @totalNet]
    #document.getElementById('totalVat').innerHTML = "Total vat" + totalVat
    
