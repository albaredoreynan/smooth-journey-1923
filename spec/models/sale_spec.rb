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

  context 'totals' do
    before do
      @sale = Sale.new(FactoryGirl.attributes_for(:sale))
    end

    it 'should return total of 0 as default' do
      @sale.category_total.should == 0
      @sale.settlement_type_total.should == 0
    end

    it 'should total categories' do
      @sale.category_sales << CategorySale.new({:amount => 10})
      @sale.category_sales << CategorySale.new({:amount => 5})
      @sale.category_total.should == 15
    end

    it 'should total settlement_types' do
      @sale.settlement_type_sales << SettlementTypeSale.new({:amount => 7})
      @sale.settlement_type_sales << SettlementTypeSale.new({:amount => 8})
      @sale.settlement_type_total.should == 15
    end

    it 'should not be valid when totals are not equal' do
      @sale.category_sales << CategorySale.new({:amount => 1})
      @sale.settlement_type_sales << SettlementTypeSale.new({:amount => 22})
      @sale.category_total.should eq 1
      @sale.settlement_type_total.should eq 22
      @sale.should_not be_valid
    end
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
