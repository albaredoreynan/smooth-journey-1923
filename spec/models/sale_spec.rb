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

  context '.category_total' do
    it 'should return category_total' do
      sale = FactoryGirl.create(:sale)
      FactoryGirl.create(:sale_category_row, :amount => 5, :sale => sale)
      FactoryGirl.create(:sale_category_row, :amount => 4, :sale => sale)
      sale.category_total.should eq 9
    end
  end

  context 'search' do
    before do
      @start_date = 6.days.ago
      @end_date = Date.today
      @sales = [
        FactoryGirl.create(:sale, :sale_date => 5.days.ago),
        FactoryGirl.create(:sale, :sale_date => @end_date)
      ]
    end

    it 'should search sales by date' do
      pending
      search_result = Sale.search_by_date(@start_date.strftime('%F'), @end_date.strftime('%F'))
      search_result.should eq [@sales[1], @sales[0]]

      search_result = Sale.search_by_date(@start_date.strftime('%F'), 4.days.ago.strftime('%F'))
      search_result.should eq [@sales[0]]
    end
  end

end
