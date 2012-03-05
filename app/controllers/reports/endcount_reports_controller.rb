class Reports::EndcountReportsController < ReportsController

  set_tab :reports

  def index
    endcount_items = EndcountItem.
      includes(:subcategory).
      where(current_ability.attributes_for(:read, Item)).
      inventory
    # TODO: please DRY this
    if params[:date]
      query_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i)
      if query_date.month == Date.today.month
        @ending_date = Date.today
      else
        @ending_date = query_date.end_of_month
      end
    else
      @ending_date = Date.today
    end
    
    if params[:branch_id]
      @branch_id = params[:branch_id]
    end
    
    @endcount = Endcount.new(endcount_items, @ending_date)
    respond_to do |wants|
      wants.html
      wants.csv do
        render_csv(params[:controller])
      end
      wants.pdf do
        headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
        render :layout => false
      end
    end
  end
end
