class Endcount < ActiveRecord::Base
  has_many :item_counts, :dependent => :destroy #when endcount is destroyed, item_count will also be destroyed
  accepts_nested_attributes_for :item_counts

  #validates :end_count, :presence => true
end
