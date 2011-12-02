class Endcount < ActiveRecord::Base
  has_many :item_counts, :dependent => :destroy

  accepts_nested_attributes_for :item_counts

  def self.search_by_date(start_date, end_date)
    if start_date && end_date.blank?
      where('begin_date >= ?', start_date)
    elsif start_date.blank? && end_date
      where('end_date <= ?', end_date)
    else
      where('begin_date >= ? AND end_date <= ?', start_date, end_date)
    end
  end
end
