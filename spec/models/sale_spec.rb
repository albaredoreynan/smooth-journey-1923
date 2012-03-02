require 'spec_helper'

describe Sale do

  it 'should save given a valid attributes' do
    sale = Sale.new(FactoryGirl.attributes_for(:sale))
    lambda {
      sale.save
    }.should change(Sale, :count).by 1
  end

  context 'Association' do
    it { should belong_to :branch }
  end

  context 'search' do
    before do
      @start_date = 6.days.ago
      @end_date = Date.today
      @sales = [
        FactoryGirl.create(:sale, :date => 5.days.ago),
        FactoryGirl.create(:sale, :date => @end_date)
      ]
    end

    it 'should search sales by date' do
      search_result = Sale.search_by_date(@start_date.strftime('%F'), @end_date.strftime('%F'))
      search_result.should eq [@sales[1], @sales[0]]

      search_result = Sale.search_by_date(@start_date.strftime('%F'), 4.days.ago.strftime('%F'))
      search_result.should eq [@sales[0]]
    end
  end

end
