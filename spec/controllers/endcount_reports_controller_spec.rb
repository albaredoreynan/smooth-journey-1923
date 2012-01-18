require 'spec_helper'

describe Reports::EndcountReportsController do
  context 'GET #index' do
    before do
      endcount_item = EndcountItem.create(FactoryGirl.attributes_for(:item))
      @endcount = Endcount.new([endcount_item], Date.today, Date.today.beginning_of_month)
    end
    it 'should load all endcounts' do
      get 'index'
      assigns[:endcount].should eq @endcount
    end
  end
end
