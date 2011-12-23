class Conversion < ActiveRecord::Base

  validates :bigger_unit_id, :presence => true
  validates :smaller_unit_id, :presence => true

  belongs_to :bigger_unit, :class_name => 'Unit'
  belongs_to :smaller_unit, :class_name=> 'Unit'

  def bigger_unit_name
    bigger_unit.name if bigger_unit
  end

  def smaller_unit_name
    smaller_unit.name if smaller_unit
  end
end
