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
    
    if params[:commit]=="Search"
        startdate = params[:start]['(1i)']+ '-' + params[:start]['(2i)'] + '-' + params[:start]['(3i)']
        enddate = params[:end]['(1i)']+ '-' + params[:end]['(2i)'] + '-' + params[:end]['(3i)']
        
        @duration = startdate + ' to ' + enddate
        @purchases = Purchase.search_by_date(startdate, enddate)
        #@categories = Category.all
    elsif params[:commit]=="Search by supplier"
        @purchases = Purchase.search_by_supplier(params[:supplier][:supplier_id])
    elsif params[:commit]=="Search by invoice"
    elsif params[:commit]=="Search by category"
        #@purchases = Purchase.search_by_category(params[:category][:category_id])
    elsif params[:commit]=="Search by subcategory"
    elsif params[:commit]=="Search by item"
    end
  end
end
