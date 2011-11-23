require 'spec_helper'

describe Subcategory do

  context 'Validation' do
    before do
      @subcategory = Subcategory.new
    end

    it 'should be invalid without name' do
      @subcategory.should have(1).error_on :name
    end

    it 'should be invalid without a category' do
      @subcategory.should have(1).error_on :category_id
    end
  end
end
