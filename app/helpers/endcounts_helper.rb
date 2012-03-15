module EndcountsHelper
  def endcount_title(date=nil)
    if date.nil?
      date = Date.today.strftime("%-d-%b-%Y")
    else
      date = Date.parse(date).strftime("%-d-%b-%Y")
    end
    et = "View Endcounts "
    et += " of branch #{@branch.location}" unless @branch.new_record?
    et += " " + content_tag(:span, "as of #{date}",
      :style => %Q{
        font-style: italic;
        color: #848484;
        font-size: 18px;
      }) if date
    return raw et
  end
end
