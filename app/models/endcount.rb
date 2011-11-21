class Endcount < ActiveRecord::Base
  has_many :item_counts, :dependent => :destroy

  accepts_nested_attributes_for :item_counts
end
