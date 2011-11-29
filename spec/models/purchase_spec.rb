require 'spec_helper'

describe Purchase do

  context 'Search' do
    before do
      @purchase1 = FactoryGirl.create(:purchase, :purchase_date => Date.today)
      @purchase2 = FactoryGirl.create(:purchase, :purchase_date => 5.days.ago)
      @start_date = 6.days.ago
      @end_date = Date.today
    end

    it 'should search purchase by date' do
      results = Purchase.search_by_date(@start_date, @end_date)
      results.should eq [@purchase1, @purchase2]
    end

    it 'should search purchase by date as string' do
      start_date = @start_date.strftime('%F')
      end_date = @end_date.to_s
      results = Purchase.search_by_date(start_date, end_date)
      results.should eq [@purchase1, @purchase2]
    end    
  end
end
