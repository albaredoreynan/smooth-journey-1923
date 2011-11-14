class ItemCount < ActiveRecord::Base
  belongs_to :endcount

  validates :end_count, :presence => true, :numericality => true
end
