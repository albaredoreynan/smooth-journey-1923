class Quantity
  attr_accessor :value, :unit

  def initialize(value, unit)
    @value = value.to_f
    case unit
    when String
      @unit = Unit.find_by_symbol(unit.to_s) || Unit.new(:symbol => unit)
    when Unit
      @unit = unit
    end
  end

  def to(unit)
    return self if unit.nil?
    conversion = Conversion.where(:bigger_unit_id => @unit.id, :smaller_unit_id => unit.id).first
    return self if conversion.nil?
    factor = conversion.conversion_factor
    Quantity.new(@value * factor, unit)
  end

  def to_s
    @value
  end
end
