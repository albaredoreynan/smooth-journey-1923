class ItemCount < ActiveRecord::Base
  belongs_to :endcount
  belongs_to :item
end
