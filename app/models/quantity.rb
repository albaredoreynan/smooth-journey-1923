class Quantity
  attr_accessor :value, :unit

  def initialize(value, unit)
    @value = value.to_f
    @unit = Unit.find_or_create_by_symbol(unit.to_s)
  end

  def to(symbol)
    unit_to = Unit.find_by_symbol(symbol)
    return self if unit_to.nil?
    conversion = Conversion.where(:bigger_unit_id => @unit.id, :smaller_unit_id => unit_to.id).first
    return self if conversion.nil?
    factor = conversion.conversion_factor
    Quantity.new(@value * factor, unit_to.symbol)
  end
end
