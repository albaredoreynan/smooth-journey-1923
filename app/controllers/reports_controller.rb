class ReportsController < ApplicationController
  
  def index
      @categories = Category.all
      @settlement_types = SettlementType.all
      @sales = Sale.where("date = ?",Date.today).group_by { |sale| sale.date.to_date }
      #@purchases = Purchase.all

      if params[:commit]=="Search"             
        @searchdate = params[:date]['(1i)']+ '-' + params[:date]['(2i)'] + '-' + params[:date]['(3i)']       
        @sales = Sale.where("date = ?",@searchdate).group_by { |sale| sale.date.to_date }
      else
        @sales = Sale.where("date = ?",Date.today).group_by { |sale| sale.date.to_date }
      end
  end
  
  def show
   #insert code 
  end
  
  def purchasereports
    @purchases = Purchase.all
  end
end
