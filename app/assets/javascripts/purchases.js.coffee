jQuery ->
  $('.update_vat_amount').change ->
    $('#vat_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[0])
    $('#net_amount').val(vatAmount($('#purchase_amount').val(), $(this).val())[1])

  $('#add-item').click ->
    purchase_id = $('#purchase_id').val()
    inputs = $(this).parents('#add_item_form').find(':input').attr('disabled', 'disabled')
    _this = this
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
      })
      success: (data) ->
        $('.purchase-items').html($(data).find(".purchase-items"))
        $('#dialog_item input:text' ).val('')
        $('#unit_id').val('')
        $('#item_id').val('')
      complete: ->
        inputs.not(_this).not('input[name=vat_type]').val('')
        inputs.removeAttr('disabled')
    })

(($) ->
  $.widget "ui.combobox",
    _create: ->
      self = this
      select = @element.hide()
      selected = select.children(":selected")
      value = (if selected.val() then selected.text() else "")
      input = @input = $("<input>").insertAfter(select).val(value).autocomplete(
        delay: 0
        minLength: 0
        source: (request, response) ->
          matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i")
          response select.children("option").map(->
            text = $(this).text()
            if @value and (not request.term or matcher.test(text))
              label: text.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + $.ui.autocomplete.escapeRegex(request.term) + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<strong>$1</strong>")
              value: text
              option: this
          )

        select: (event, ui) ->
          ui.item.option.selected = true
          self._trigger "selected", event,
            item: ui.item.option

        change: (event, ui) ->
          unless ui.item
            matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex($(this).val()) + "$", "i")
            valid = false
            select.children("option").each ->
              if $(this).text().match(matcher)
                @selected = valid = true
                false

            unless valid
              $(this).val ""
              select.val ""
              input.data("autocomplete").term = ""
              false
      ).addClass("ui-widget ui-widget-content ui-corner-left").css('width', '60%')
      input.data("autocomplete")._renderItem = (ul, item) ->
        $("<li></li>").data("item.autocomplete", item).append("<a>" + item.label + "</a>").appendTo ul

      @button = $("<button type='button'>&nbsp;</button>").attr("tabIndex", -1).attr("title", "Show All Items").insertAfter(input).button(
        icons:
          primary: "ui-icon-triangle-1-s"

        text: false
      ).removeClass("ui-corner-all").addClass("ui-corner-right ui-button-icon").click(->
        if input.autocomplete("widget").is(":visible")
          input.autocomplete "close"
          return
        $(this).blur()
        input.autocomplete "search", ""
        input.focus()
      )

    destroy: ->
      @input.remove()
      @button.remove()
      @element.show()
      $.Widget::destroy.call this
) jQuery
$ ->
  $("#item_id").combobox()

