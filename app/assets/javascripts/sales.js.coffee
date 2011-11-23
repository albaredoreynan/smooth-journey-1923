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
  totalGross1 = $('#gross_total')
  totalGross2 = $('#sale_gross_total_ss')
  saveButton = $('#sale_submit')
  saveButton.disabled = false
  if totalGross1.val() != totalGross2.val()
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
  totalAmount = $('#sale_gross_total_ss')
  vatAmount = 0
  if totalAmount.val() == ""

  else
    vatAmount = totalAmount.val() * 0.12

    totalVat = vatAmount
    netTotal = totalAmount.val() - totalVat

    totalVatField = $('#sale_vat')
    totalVatField.val(totalVat)
    netField = $('#sale_net_total_ss')
    netField.val(netTotal)
  checkTotal()

updateVatAmount2 = ->
  totalAmount = $('#sale_total_amount_cs')
  vatAmount = 0
  totalGross = 0
  if totalAmount.value == ""

  else
    vatAmount = totalAmount.value * 0.12

    totalVat = vatAmount

    totalVatField = $('#vat')
    totalVatField.val(totalVat)

    totalGrossField = $('#gross_total')
    totalGross = totalAmount.val() * 0.12 + totalAmount.val() * 1
    totalGrossField.val(totalGross)

  checkTotal()

computeTotal = ->
  serviceCharge = $('#sale_service_charge')
  totalGross = 0
  if serviceCharge.value == ""

  else
    totalAmount = $('#sale_total_amount_cs')

    totalGrossField = $('#gross_total')
    totalGross = totalAmount.val() * 0.12 + totalAmount.val() * 1 + serviceCharge.val() * 1
    totalGrossField.val(totalGross)

  checkTotal()
