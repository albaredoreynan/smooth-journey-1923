module EndMonth
  def month_to_date_or_last_day_of_month
    @ending_date = Date.today
    
    if params[:date]
      #query_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i)     
      query_date = Date.strptime(params[:date], '%Y-%m-%d')
      unless Date.parse(query_date.to_s) == Date.today
        @ending_date = Date.parse(query_date.to_s).end_of_month
      end
    end
  end
end
