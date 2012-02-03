require 'spec_helper'

describe Quantity do
  before do
    @cm_unit = FactoryGirl.create(:unit, :symbol => 'cm')
    @in_unit = FactoryGirl.create(:unit, :symbol => 'in')
    FactoryGirl.create(:conversion,
                       :bigger_unit => @in_unit,
                       :smaller_unit => @cm_unit,
                       :conversion_factor => 2.54)
  end

  it 'should create a valid quantity with a unit' do
    quantity = Quantity.new(100, 'cm')
    quantity.value.should eq 100
    quantity.unit.symbol.should eq 'cm'
  end

  it 'should create unit when there is no unit' do
    quantity = Quantity.new(100, 'non-existing-unit')
    quantity.value.should eq 100
    quantity.unit.symbol.should eq 'non-existing-unit'
  end

  it 'should return Quantity object on convert' do
    quantity = Quantity.new(100, @in_unit)
    quantity.to(@cm_unit).should be_instance_of Quantity
  end

  it 'should convert length correctly' do
    quantity = Quantity.new(100, @in_unit)
    quantity.to(@cm_unit).value.should eq 254
  end

  it 'should return default if unit-to does not exists' do
    qty = Quantity.new(100, 'rare-unit')
    qty_to = qty.to(FactoryGirl.create(:unit))
    qty_to.value.should eq qty.value
    qty_to.unit.symbol.should eq qty.unit.symbol
  end

  it 'should return default value and unit if conversion-to does not exists' do
    qty = Quantity.new(100, @cm_unit.symbol)
    xunit = FactoryGirl.create(:unit, :symbol => 'xunit')
    qty_to = qty.to(xunit)
    qty_to.value.should eq qty.value
    qty_to.unit.symbol.should eq qty.unit.symbol
  end
end
