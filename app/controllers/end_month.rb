module EndMonth
  def month_to_date_or_last_day_of_month
    @ending_date = Date.today
    
    if params[:date]
      query_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i)     
      unless query_date.month == Date.today.month
        @ending_date = query_date.end_of_month
      end
      #query_date = Date.strptime(params[:date], '%Y-%m-%d')
      #unless Date.parse(query_date.to_s) == Date.today
        #@ending_date = Date.parse(query_date.to_s).end_of_month
      #end
    end
  end
  
  def month_to_date_or_last_day_of_month_endcounts
    @ending_date = Date.today
    
    if params[:date]
      query_date = Date.strptime(params[:date], '%Y-%m-%d')
      unless Date.parse(query_date.to_s) == Date.today
        @ending_date = Date.parse(query_date.to_s).end_of_month
      end
    end
  end
end
