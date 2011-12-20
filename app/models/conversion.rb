class Conversion < ActiveRecord::Base

  validates :bigger_unit_id, :presence => true
  validates :smaller_unit_id, :presence => true

  belongs_to :bigger_unit, :class_name => 'Unit'
  belongs_to :smaller_unit, :class_name=> 'Unit'
end
