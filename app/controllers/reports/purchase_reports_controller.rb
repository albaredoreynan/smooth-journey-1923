class Reports::PurchaseReportsController < ReportsController

  set_tab :reports

  def index
    @start_date = params[:start_date] || Date.today.beginning_of_month
    @end_date = params[:end_date] || Date.today
    @purchase_items = PurchaseItem.accessible_by(current_ability).search(
      :start_date => @start_date,
      :end_date => @end_date,
      :supplier => params[:supplier],
      :invoice_number => params[:invoice_number],
      :item => params[:item],
      :subcategory => params[:subcategory]
    ).group_by do |pi|
      pi.item.subcategory || Subcategory.new(:name => '(No subcategory)')
    end

    respond_to do |wants|
      wants.html
      wants.csv do
        filename = params[:controller]
        render_csv(filename)
      end
      wants.pdf do
        headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
        render :layout => false
      end
    end
  end
end
