class ReportsController < ApplicationController

  set_tab :reports

  def index
    endcount_items = EndcountItem.where(current_ability.attributes_for(:read, Item))
    @endcount = Endcount.new(endcount_items, Date.today, Date.today.beginning_of_month)
  end
end
