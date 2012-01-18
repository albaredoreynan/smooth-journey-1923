class Reports::EndcountReportsController < ApplicationController

  set_tab :reports

  def index
    endcount_items = EndcountItem.where(current_ability.attributes_for(:read, Item))
    if params[:month] && params[:year]
      ending_date = Date.new(params[:year].to_i, params[:month].to_i)
    else
      ending_date = Date.today
    end
    @endcount = Endcount.new(endcount_items, ending_date)
  end
end
