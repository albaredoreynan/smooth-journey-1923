class Quantity
  attr_accessor :value, :unit

  def initialize(value, unit)
    @value = value.to_f
    @unit = Unit.find_by_symbol(unit.to_s)
  end

  def to(symbol)
    unit_to = Unit.find_by_symbol(symbol)
    conversion = Conversion.where(:bigger_unit_id => @unit.id, :smaller_unit_id => unit_to.id).first
    factor = conversion.conversion_factor
    @value * factor
  end
end
