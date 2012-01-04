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

  it 'should convert length correctly' do
    quantity = Quantity.new(100, 'in')
    quantity.to('cm').should eq 254
  end
end
