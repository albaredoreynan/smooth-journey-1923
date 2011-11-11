require 'spec_helper'

describe Company do

  context 'Validation' do
    before do
      @company = Company.new
    end

    it 'should have company name' do
      @company.should have(1).error_on :company_name
    end
  end

  context 'Association' do
    it { should have_many :restaurants }
  end
end
