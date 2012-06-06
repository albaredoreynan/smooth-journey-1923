module Reports::EndcountReportsHelper
  def endcount_reports_title(date=nil)
    if date.nil?
      date = Date.today
    else
      date = params[:date]
    end
    et = "Item Cost Analysis"
    et += " " + content_tag(:span, "As of #{date}",
      :style => %Q{
        font-style: italic;
        color: #848484;
        font-size: 18px;
      }) if date
    return raw et
  end
end
