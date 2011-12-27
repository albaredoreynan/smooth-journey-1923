module EndcountsHelper
  def endcount_title(date=nil)
    et = "View Endcounts"
    et += " as of #{date}" if date
    return et
  end
end
