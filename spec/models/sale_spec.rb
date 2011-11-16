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

  context 'Total attributes' do
    before do
      @sale = Sale.new
    end

    it 'should total categories' do
      @sale.category_sales << CategorySale.new({:amount => 10})
      @sale.category_sales << CategorySale.new({:amount => 5})
      @sale.category_total.should == 15
    end

    it 'should total settlement_types' do
      @sale.settlement_type_sales << SettlementTypeSale.new({:ss_amount => 7})
      @sale.settlement_type_sales << SettlementTypeSale.new({:ss_amount => 8})
      @sale.settlement_type_total.should == 15
    end
  end

end
