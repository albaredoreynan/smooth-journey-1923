class Endcount < ActiveRecord::Base
  has_many :item_counts, :dependent => :destroy

  accepts_nested_attributes_for :item_counts

  def self.search(start_date, end_date)
    where('begin_date >= ? and end_date <= ?', start_date, end_date)
  end
end
