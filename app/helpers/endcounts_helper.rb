module EndcountsHelper
  def endcount_title(date=nil)
    et = "View Endcounts"
    et += " " + content_tag(:span, "as of #{date}",
      :style => %Q{
        font-style: italic;
        color: #848484;
        font-size: 18px;
      }) if date
    return raw et
  end
end
