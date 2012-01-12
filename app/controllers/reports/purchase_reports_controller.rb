class Reports::PurchaseReportsController < ApplicationController

  set_tab :reports

  def index
    @purchase_items = PurchaseItem.search_by_date(Date.today.beginning_of_month, Date.today).group_by do |pi|
      pi.item.subcategory
    end
  end
end