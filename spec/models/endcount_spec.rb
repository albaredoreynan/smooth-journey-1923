require 'spec_helper'

describe Endcount do
  context 'Search' do
    before do
      @endcount1 = FactoryGirl.create(:endcount, :begin_date => 30.days.ago,
                                                 :end_date => 15.days.ago)
      @endcount2 = FactoryGirl.create(:endcount, :begin_date => 7.days.ago,
                                                 :end_date => 2.days.ago)
    end
    it 'should search endcount by date' do
      start_date = 30.days.ago
      endcounts = Endcount.search(start_date, 15.days.ago)
      endcounts.should eq [@endcount1]

      endcounts = Endcount.search(start_date, Date.today)
      endcounts.should eq [@endcount1, @endcount2]0
    end
    
    it 'should search endcount by date as string' do
      start_date = @endcount1.strftime('%F')
      end_date = @endcount2.to_s
      results = Endcount.search_by_date(start_date, end_date)
      results.should eq [@endcount1, @endcount2]
    end
  end
end
