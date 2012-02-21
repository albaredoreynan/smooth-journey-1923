require 'spec_helper'

describe Sale do

  it 'should save given a valid attributes' do
    sale = Sale.new(FactoryGirl.attributes_for(:sale))
    lambda {
      sale.save
    }.should change(Sale, :count).by 1

    lambda {
      sale = Sale.create(
        "branch_id"=>"1",
        "customer_count"=>"100",
        "date(1i)"=>"2011",
        "date(2i)"=>"11",
        "date(3i)"=>"16",
        "delivery_pta"=>"10",
        "delivery_sales"=>"10",
        "delivery_tc"=>"10",
        "dinein_cc"=>"10",
        "dinein_ppa"=>"10",
        "dinein_pta"=>"10",
        "dinein_tc"=>"10",
        "employee_id"=>"1",
        "gross_total_ss"=>"20",
        "net_total_ss"=>"17.6",
        "service_charge"=>"10",
        "takeout_pta"=>"10",
        "takeout_tc"=>"10",
        "total_amount_cs"=>"30",
        "total_revenue_cs"=>"10",
        "transaction_count"=>"50",
        "vat"=>"2.4",
        "void"=>"1",
      )
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
