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
      start_date = @start_date.strftime('%Y-%m-%d')
      end_date = @end_date.to_s
      results = Purchase.search_by_date(start_date, end_date)
      results.should eq [@purchase1, @purchase2]
    end

    it 'should search date from hash params' do
      params = {"start"=>{
        "(1i)"=> @start_date.year,
        "(2i)"=> @start_date.month,
        "(3i)"=> @start_date.day
      },
      "end"=>{
        "(1i)"=> @end_date.year,
        "(2i)"=> @end_date.month,
        "(3i)"=> @end_date.day
      }}
      results = Purchase.search_by_date(params['start'], params['end'])
      results.should eq [@purchase1, @purchase2]
    end
  end
end
