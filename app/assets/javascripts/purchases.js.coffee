jQuery ->
  $('.update_vat_amount').change ->
    $('#vat_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[0])
    $('#net_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[1])
  $('.add-item').click ->
    purchase_item_row = $('.purchase-item-row').first().clone()
    purchaseItemColumn(purchase_item_row.find('.item_id'))
    purchaseItemColumn(purchase_item_row.find('.unit_id'))
    purchaseItemColumn(purchase_item_row.find('.unit_cost'))
    purchaseItemColumn(purchase_item_row.find('.quantity'))
    purchaseItemColumn(purchase_item_row.find('.amount'))
    purchaseItemColumn(purchase_item_row.find('.vat_type'))
    purchase_item_row.appendTo('.purchase-items').show()

purchaseItemColumn = (column,count=1) ->
  sourceColumn = $('#purchase_purchaserows_attributes_0_'+column.attr('class'))
  value = $('#purchase_purchaserows_attributes_0_'+column.attr('class')+':input').val()
  if (sourceColumn.hasClass('select'))
    column.text($('#purchase_purchaserows_attributes_0_'+column.attr('class')+' option:selected').text())
  else
    column.text(value)

  column.append($('<input/>')
    .attr({
      'type': 'hidden',
      'name': 'purchase[purchaserows_attributes]['+count+']['+column.attr('class')+']'
    })
    .val(value)
  )

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
