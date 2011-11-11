require 'spec_helper'

describe Category do

  context 'Validation' do
    before do
      @category = Category.new
    end

    it 'should be invalid without name' do
      @category.should have(1).error_on :name
    end
  end

  context 'Association' do
    it { should have_many :subcategories }
  end
end
