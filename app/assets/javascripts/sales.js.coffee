jQuery ->
  $('#sale_gross_total_ss, #gross_total_ss').keyup ->
    computeVat()
  $('#sale_service_charge, #service_charge').change ->
    computeTotal()
  $('input.settlementtype').change ->
    calculateSettlementtypeTotal()
  $('input.category').change ->
    calculateCategoryTotal()

checkTotal = ->
  totalGross1 = document.getElementById 'gross_total'
  totalGross2 = document.getElementById 'sale_gross_total_ss'
  saveButton = document.getElementById 'sale_submit'
  saveButton.disabled = false
  if totalGross1.value != totalGross2.value
    saveButton.disabled = true

computeVat = ->
  $('#sale_vat').val($('#sale_gross_total_ss').val() * .12)

calculateCategoryTotal = ->
  total = 0

  $(".category").each ->
    if !isNaN(@value) && @value.length != 0
      total += parseFloat(@value)

  $("#sale_total_amount_cs").val(total)
  updateVatAmount2()

calculateSettlementtypeTotal = ->
  total = 0

  $(".settlementtype").each ->
    if !isNaN(@value) && @value.length != 0
      total += parseFloat(@value)

  $("#sale_gross_total_ss").val(total)
  updateVatAmount()

updateVatAmount = ->
  totalAmount = document.getElementById('sale_gross_total_ss')
  vatAmount = 0
  if totalAmount.value == ""

  else
    vatAmount = totalAmount.value * 0.12

    totalVat = vatAmount
    netTotal = totalAmount.value - totalVat

    totalVatField = document.getElementById('sale_vat')
    totalVatField.value = totalVat
    netField = document.getElementById('sale_net_total_ss')
    netField.value = netTotal
  checkTotal()

updateVatAmount2 = ->
  totalAmount = document.getElementById('sale_total_amount_cs')
  vatAmount = 0
  totalGross = 0
  if totalAmount.value == ""

  else
    vatAmount = totalAmount.value * 0.12

    totalVat = vatAmount

    totalVatField = document.getElementById('vat')
    totalVatField.value = totalVat

    totalGrossField = document.getElementById('gross_total')
    totalGross = totalAmount.value * 0.12 + totalAmount.value * 1
    totalGrossField.value = totalGross

  checkTotal()

computeTotal = ->
  serviceCharge = document.getElementById('sale_service_charge')
  totalGross = 0
  if serviceCharge.value == ""

  else
    totalAmount = document.getElementById('sale_total_amount_cs')

    totalGrossField = document.getElementById('gross_total')
    totalGross = totalAmount.value * 0.12 + totalAmount.value * 1 + serviceCharge.value * 1
    totalGrossField.value = totalGross

  checkTotal()
