jQuery ->
  $('.update_vat_amount').change ->
    $('#vat_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[0])
    $('#net_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[1])

  $('#add-item').click ->
    purchase_id = $('#purchase_id').val()
    $.ajax({
      type: "POST",
      url: "/purchases/"+purchase_id+"/purchase_items/",
      data: ({
        _method: "post",
        purchase_item: {
          item_id: $('#item_id').val(),
          unit_id: $('#unit_id').val(),
          unit_cost: $('#unit_cost').val(),
          quantity: $('#quantity').val(),
          amount: $('#amount').val(),
          vat_type: $(':input[name=vat_type]:checked').val(),
        }
      }),
      complete: ->
        window.location.reload()
    })

vatAmount = (amount, vat) ->
  net_amount = amount
  switch vat
    when 'VAT-Inclusive'
      vat_amount = amount / 1.12
      vat_amount = amount - vat_amount
      net_amount = amount - vat_amount
    when 'VAT-Exclusive'
      vat_amount = amount * 0.12
    when 'VAT-Exempted'
      vat_amount = amount
  [vat_amount, net_amount]

updateUQA = ->
  length = form.elements.length
  i = 0

  while i < length
    unitCost = form.elements[i].value
    mark = form.element[i + 3].value
    purchase_amount = undefined
    if mark is form.elements[12].value
      purchase_amount = (unitCost) * (form.elements[i + 1].value)
      form.elements[i + 2].value = purchase_amount
