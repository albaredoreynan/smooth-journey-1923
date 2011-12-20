require 'spec_helper'

describe Conversion do

  before do
    @bigger_unit = FactoryGirl.create(:unit, :name => 'in')
    @smaller_unit = FactoryGirl.create(:unit, :name => 'cm')
    @conversion = FactoryGirl.create(:conversion, :bigger_unit => @bigger_unit, :smaller_unit => @smaller_unit)
  end

  it 'should create a conversion' do
    lambda {
      conversion = FactoryGirl.create(:conversion, :bigger_unit => @bigger_unit, :smaller_unit => @smaller_unit)
    }.should change(Conversion, :count).by(1)
  end

  it 'should return bigger unit name' do
    @conversion.bigger_unit_name.should eq 'in'
  end

  it 'should return smaller unit name' do
    @conversion.smaller_unit_name.should eq 'cm'
  end

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

end
