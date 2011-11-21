class ItemCount < ActiveRecord::Base
  belongs_to :endcount
  belongs_to :item

  validates :end_count, :presence => true, :numericality => true

end
