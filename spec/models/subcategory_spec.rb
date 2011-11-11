require 'spec_helper'

describe Subcategory do

  context 'Validation' do
    it 'should be invalid without name' do
      subcategory = Subcategory.new
      subcategory.should have(1).error_on :subcategory_name
    end
  end
end
