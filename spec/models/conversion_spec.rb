require 'spec_helper'

describe Conversion do

  context 'Validation' do
    before do
      @conversion = Conversion.new
    end

    it 'should be invalid without bigger_unit' do
      @conversion.should have(1).error_on(:bigger_unit_id)
    end

    it 'should be invalid without smaller unit' do
      @conversion.should have(1).error_on(:smaller_unit_id)
    end
  end

  it 'should create a conversion' do
    @bigger_unit = FactoryGirl.create(:unit, :name => 'in')
    @smaller_unit = FactoryGirl.create(:unit, :name => 'cm')
    lambda {
      @conversion = FactoryGirl.create(:conversion, :bigger_unit => @bigger_unit, :smaller_unit => @smaller_unit)
    }.should change(Conversion, :count).by(1)
  end

  it 'should create conversion from factory' do
    conversion = FactoryGirl.create(:conversion)
  end
end
