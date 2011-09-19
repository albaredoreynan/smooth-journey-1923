class ReportsController < ApplicationController
  
  def index
      @categories = Category.all
      @categorysales = Categorysale.where("cs_date = ?",Date.today)
      
      if params[:commit]=="Search"     
        @searchdate = params[:date]['(1i)']+ '-' + params[:date]['(2i)'] + '-' + params[:date]['(3i)']
        @categorysales = Categorysale.where("cs_date = ?",@searchdate) 
      else
        @categorysales = Categorysale.where("cs_date = ?",Date.today)
      end
  end
  
  def show

  end
  
end
