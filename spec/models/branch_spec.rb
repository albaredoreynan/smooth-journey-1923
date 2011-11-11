require 'spec_helper'

describe Branch do

  context 'Validation' do
    before do
      @branch = Branch.new
    end

    it 'should be invalid without location' do
      @branch.should have(1).error_on :branch_location
    end
  end

  context 'Association' do
    it { should belong_to :restaurant }
  end
end
