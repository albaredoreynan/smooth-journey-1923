jQuery ->
  $('.updates_vat_amount').change ->
    updateVatAmount()
updateVatAmount = ->
  console.log('updateVatAmount')
  purchaseAmount = $('#purchase_item_amount')
  vatAmount = 0
  netAmount = 0

  if purchaseAmount.value == ""
  else
    checkVat = ->
      if $('#purchase_item_vat_type_vat-inclusive').is(':checked')
        vatAmount = purchaseAmount.value / 1.12
        vatAmount = purchaseAmount.value - vatAmount
        netAmount = purchaseAmount.value - vatAmount
        #vatAmount = purchaseAmount.value * (3/28)

      if $('#purchase_item_vat_type_vat-exclusive').is(':checked')
        vatAmount = purchaseAmount.value * .12
        netAmount = purchaseAmount.value

      if $('#purchase_item_vat_type_vat-exempted').is(':checked')
        vatAmount = 0
        netAmount = purchaseAmount.value

    checkVat()
    totalVat = vatAmount
    totalNet = netAmount
    #document.getElementById('totalVat').innerHTML = "Total vat" + totalVat
    totalVatField = document.getElementById('vat_amount')
    totalVatField.value = totalVat

    totalNetField = document.getElementById('net_amount')
    totalNetField.value = totalNet

    document.getElementById("paP").innerHTML = $('#purchase_item_amount').value
    document.getElementById("vaP").innerHTML = $('#vat_amount').value
    document.getElementById("naP").innerHTML = $('#net_amount').value

  document.getElementById("ucP").innerHTML = $('#purchase_item_unit_cost').value
  document.getElementById("pqP").innerHTML = $('#purchase_item_amount').value
