module Reports::PurchaseReportsHelper
  def purchase_reports_title(start_date=nil, end_date=nil)
    if start_date.blank? || end_date.blank?
      start_date = Date.today.beginning_of_month
      end_date = Date.today
    else
      start_date = start_date
      end_date = end_date
    end
    et = "Purchase Reports"
    et += " " + content_tag(:span, "From #{start_date} To #{end_date}",
      :style => %Q{
        font-style: italic;
        color: #848484;
        font-size: 18px;
      }) if start_date && end_date
    return raw et
  end
end
