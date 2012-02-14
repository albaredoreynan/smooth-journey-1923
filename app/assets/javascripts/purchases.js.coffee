jQuery ->
  $('#new_purchase_item')
    .live 'ajax:beforeSend', (event, xhr) ->
      # disable form elements
      $(this).find(':input').attr('disabled', 'disabled')

    .live 'ajax:success', (event, data) ->
      $('div#main div.flash').remove()
      $('table#purchase_items tbody').append(data)
      $('#unit_id, #item_id').val('')
      $('td#purchase_total_amount').trigger('change')

    .live 'ajax:error', (event, xhr, status) ->
      $('div#main div.flash').remove()
      $('div#main').prepend($('<div></div>').attr('class', 'flash')
        .append($('<div></div>').attr('class', 'message alert')
          .html('Unable to add item. Please try again.')))

    .live 'ajax:complete', (event, data) ->
      # re-enable form elements
      inputs = $(this).find(':input')
      inputs.not('input[type=submit], input[name=purchase_item[vat_type]').val('')
      inputs.removeAttr('disabled')

  $('td#purchase_total_amount').change ->
    total = 0
    amounts = $('td.item-amount').map ->
      parseFloat($(this).html().trim())
    $(amounts).each (index, value) ->
      total += value
    $(this).html((total).toFixed(2))


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

  $("#purchase_item_item_id").combobox selected: (event, ui) ->
    $.ajax
      url: "/inventoryitems/" + ui.item.value + "/available_units"
      dataType: "json"
      success: (data) ->
        unit_id = $('#purchase_item_unit_id')
        unit_id.empty()
        $(data).each (index, elem) ->
          unit_id.append $("<option></option>").attr("value", elem.id).text(elem.name)
