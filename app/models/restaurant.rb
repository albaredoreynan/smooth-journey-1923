class Restaurant < ActiveRecord::Base
  belongs_to :company
  has_one :branch
end
