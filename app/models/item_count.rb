class ItemCount < ActiveRecord::Base
  belongs_to :endcount
  belongs_to :item, :foreign_key => 'inventoryitem_id'

  validates :end_count, :presence => true, :numericality => true

end
