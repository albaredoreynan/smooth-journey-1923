jQuery ->
  $('#show_by_date').datepicker
    dateFormat: 'yy-mm-dd'
    onSelect: (dateText, inst) ->
      window.location = '/endcounts/?date='+dateText
