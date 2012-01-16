class Reports::PurchaseReportsController < ApplicationController

  set_tab :reports

  def index
    start_date = params[:start_date] || Date.today.beginning_of_month
    end_date = params[:end_date] || Date.today
    @purchase_items = PurchaseItem.search(
      start_date: start_date,
      end_date: end_date,
      supplier: params[:supplier],
      invoice_number: params[:invoice_number],
      item: params[:item],
    ).group_by do |pi|
      pi.item.subcategory || Subcategory.new(:name => '(No subcategory)')
    end
  end
end
