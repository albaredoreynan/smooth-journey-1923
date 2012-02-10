module Reports::EndcountReportsHelper
  def endcount_reports_title(date_month=nil, date_year=nil)
    if date_month.nil? && date_year.nil?
      date_month = Date.today.strftime('%B')
      date_year = Date.today.strftime('%Y')
    else
      date_month = Date::MONTHNAMES[params[:date][:month].to_i]

      date_year = params[:date][:year]
    end
    et = "Item Cost Analysis"
    et += " " + content_tag(:span, "As of #{date_month}, #{date_year}",
      :style => %Q{
        font-style: italic;
        color: #848484;
        font-size: 18px;
      }) if date_month && date_year
    return raw et
  end
end
