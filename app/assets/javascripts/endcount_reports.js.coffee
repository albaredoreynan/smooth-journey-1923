jQuery ->      
  $('#show_by_date_reports').datepicker
    dateFormat: 'yy-mm-dd'
    onSelect: (dateText, inst) ->
      window.location = '/reports/endcounts/?date='+dateText
