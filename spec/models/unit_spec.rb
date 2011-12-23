require 'spec_helper'

describe Unit do

  context 'Validation' do
    it 'should be invalid without symbol' do
      unit = Unit.new
      unit.should have(1).error_on :symbol
    end
  end

  context 'Search' do
    before do
      @unit = FactoryGirl.create(:unit, :symbol => 'sym', :name => 'Unit')
    end

    it 'should search a symbol' do
      @units = Unit.search('sym')
      @units.should eq [@unit]
    end

    it 'should search a unit name' do
      @units = Unit.search('unit')
      @units.should eq [@unit]
    end

    it 'should not return result if no item found' do
      @units = Unit.search('ab')
      @units.should be_empty
    end
  end
end

