class Inventoryitem < ActiveRecord::Base
	belongs_to :unit
	has_many :purchase_items
end
