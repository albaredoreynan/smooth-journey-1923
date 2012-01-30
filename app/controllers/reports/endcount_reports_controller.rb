class Reports::EndcountReportsController < ApplicationController

  set_tab :reports

  def index
    endcount_items = EndcountItem.includes(:subcategory).where(current_ability.attributes_for(:read, Item))
    if params[:date]
      ending_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i)
    else
      ending_date = Date.today
    end
    @endcount = Endcount.new(endcount_items, ending_date)

    respond_to do |wants|
      wants.html
      wants.csv do
        render_csv(params[:controller])
      end
    end
  end
end
