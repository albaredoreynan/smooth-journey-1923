require 'spec_helper'

describe SaleCategory do
  context 'Validation' do
    before do
      @sale_category = SaleCategory.new
    end

    it 'should be invalid without a name' do
      @sale_category.should have(1).error_on :name
    end
  end

  context 'Association' do
    it { should belong_to :restaurant }
  end
end
