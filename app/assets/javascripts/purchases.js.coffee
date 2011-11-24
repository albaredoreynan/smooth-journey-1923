console.log('purchases loaded')

updateVatAmount = (form) ->
  length = form.elements.length
  i = 0

  while i < length
    amount = form.elements[i].value
    next = form.elements[i + 1].value
    if next is form.elements[13].value
      unitCost = form.elements[i - 2].value
      quantity = form.elements[i - 1].value
      product = unitCost * quantity
      form.elements[i].value = product
      if form.elements[i + 1].checked
        vatAmount = amount / 1.12
        vatAmount = amount - vatAmount
        netAmount = amount - vatAmount
      if form.elements[i + 2].checked
        vatAmount = amount * .12
        netAmount = amount
      if form.elements[i + 3].checked
        vatAmount = 0
        netAmount = amount
      form.elements[i + 4].value = vatAmount
      form.elements[i + 5].value = netAmount
    ++i

updateUQA = (form) ->
  length = form.elements.length
  i = 0

  while i < length
    unitCost = form.elements[i].value
    mark = form.element[i + 3].value
    purchase_amount = undefined
    if mark is form.elements[12].value
      purchase_amount = (unitCost) * (form.elements[i + 1].value)
      form.elements[i + 2].value = purchase_amount
