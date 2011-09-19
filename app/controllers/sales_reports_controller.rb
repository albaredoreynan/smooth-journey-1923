class SalesReportsController < ApplicationController

  def index
    @category_sales = Categorysale.where("date = ?",Date.today.to_s)
    @settlement_sales = SettlementSale.where("ss_date = ?",Date.today.to_s)
  end
end
