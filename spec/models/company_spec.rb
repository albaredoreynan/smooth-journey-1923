require 'spec_helper'

describe Company do

  it 'should save company given a valid attributes' do
    Company.create!({:name => 'Company A'})
  end

  context 'Validation' do
    before do
      @company = Company.new
    end

    it 'should have company name' do
      @company.should have(1).error_on :name
    end
  end

  context 'Association' do
    it { should have_many :restaurants }
    it { should have_one :setting }
  end
end
