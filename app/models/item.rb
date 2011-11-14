class Item < ActiveRecord::Base
  belongs_to :unit
  belongs_to :branch
  has_many :purchase_items
end
