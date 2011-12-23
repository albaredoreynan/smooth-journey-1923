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
      success: (data) ->
        $('.purchase-items').html($(data).find(".purchase-items"))
        $('#dialog_item input:text' ).val('')
        $('#unit_id').val('')
        $('#item_id').val('')
        $('#dialog_item input:radio' ).attr("checked", false)
        $('#dialog_item').dialog( "close" )
    })

