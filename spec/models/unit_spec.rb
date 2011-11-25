require 'spec_helper'

describe Unit do

  context 'Validation' do
    it 'should be invalid without name' do
      unit = Unit.new
      unit.should have(1).error_on :name
    end
  end

  context 'Search' do
    before do
      @unit = Unit.create!({:name => 'Unit'})
    end

    it 'should search an unit' do
      @units = Unit.search('Unit')
      @units.first.name.should eq 'Unit'
    end

    it 'should not return result if no item found' do
      @units = Unit.search('ab')
      @units.should be_empty
    end
  end
end

