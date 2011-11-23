require 'spec_helper'

describe Branch do

  context 'Validation' do
    before do
      @branch = Branch.new
    end

    it 'should be invalid without location' do
      @branch.should have(1).error_on :location
    end

    it 'should be invalid without a restaurant_id' do
      @branch.should have(1).error_on :restaurant_id
    end
  end

  context 'Association' do
    it { should belong_to :restaurant }
  end
end
