module PurchasesHelper
  def purchase_item_unit_cost(purchase_item)
    unit_cost = number_to_currency(purchase_item.unit_cost, :unit => peso_sign)
    raw "#{unit_cost}/#{purchase_item.unit_symbol}"
  end

  def link_to_delete(resource, options={}, html_options={})
    options.reverse_merge! :dataType => 'script'
    options.reverse_merge! :success => %Q{
      function(r){
        var row = $('##{dom_id resource}');
        row.fadeOut('hide');
        row.next().remove();
      }
    }
    link_to_function_delete(options, html_options)
  end

  def link_to_function_delete(options, html_options)
    link_to_function 'Delete', link_to_function_delete_ajax(options), html_options
  end

  def link_to_function_delete_ajax(options)
    %Q{
      $(function(){
        $.ajax({
          type: 'POST',
          url: '#{options[:url]}',
          data: ({_method: 'delete'}),
          dataType: '#{options[:dataType]}',
          success: #{options[:success]}
        });
      });
    }
  end
end
