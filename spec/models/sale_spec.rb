require 'spec_helper'

describe Sale do

  context 'Validation' do
    before do
      @sale = Sale.new
    end

    it 'should be invalid without a branch' do
      @sale.should have(1).error_on :branch_id
    end

    it 'should be invalid without a date' do
      @sale.should have(1).error_on :sale_date
    end

    it 'should be invalid if total revenue and total settlement type sales are not equal' do
      sale = Sale.new(FactoryGirl.attributes_for(:sale))
      sale.stub(:total_revenue => 1)
      sale.stub(:total_settlement_type_sales => 2)
      sale.stub(:server_sale_total => 1)
      sale.stub(:cash_for_deposit => 1)
      sale.should_not be_valid
    end

    it 'should be invalid if cash for deposit and sale servers are not equal' do
      sale = Sale.new(FactoryGirl.attributes_for(:sale))
      sale.stub(:total_revenue => 1)
      sale.stub(:total_settlement_type_sales => 1)
      sale.stub(:server_sale_total => 1)
      sale.stub(:cash_for_deposit => 1)
      sale.should_not be_valid
    end
  end

  it 'should save given a valid attributes' do
    branch = FactoryGirl.create(:branch)
    sale = Sale.new(FactoryGirl.attributes_for(:sale, :branch_id => branch.id))
    lambda {
      sale.save
    }.should change(Sale, :count).by 1
  end

  context 'Association' do
    it { should belong_to :branch }
    it { should have_many :sale_servers }
  end

  context '.category_total' do
    it 'should return category_total' do
      sale = FactoryGirl.create(:sale)
      FactoryGirl.create(:sale_category_row, :amount => 5, :sale => sale)
      FactoryGirl.create(:sale_category_row, :amount => 4, :sale => sale)
      sale.reload.category_total.should eq 9
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
      search_result = Sale.search_by_date(@start_date.strftime('%F'), @end_date.strftime('%F'))
      search_result.should eq [@sales[1], @sales[0]]

      search_result = Sale.search_by_date(@start_date.strftime('%F'), 4.days.ago.strftime('%F'))
      search_result.should eq [@sales[0]]
    end
  end

  context 'Calculators' do
    before do
      # based on actual data
      restaurant = FactoryGirl.create(:restaurant)
      branch = FactoryGirl.create(:branch, :restaurant => restaurant)

      sale_categories = [
        FactoryGirl.create(:sale_category, :name => 'Food', :restaurant => restaurant),
        FactoryGirl.create(:sale_category, :name => 'Beverage', :restaurant => restaurant),
        FactoryGirl.create(:sale_category, :name => 'Beer', :restaurant => restaurant),
        FactoryGirl.create(:sale_category, :name => 'Liquor', :restaurant => restaurant),
      ]
      settlement_types = [
        FactoryGirl.create(:settlement_type, :name => 'Cash', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Credit Card', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 91', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 92', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 93', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 94', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 95', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 96', :branch => branch),
        FactoryGirl.create(:settlement_type, :name => 'Comp 97', :branch => branch),
      ]

      servers = [
        FactoryGirl.create(:server, :branch => branch),
        FactoryGirl.create(:server, :branch => branch),
      ]

      sale_params = {
        :branch_id => branch.id, :sale_date => Date.today,
        :sale_category_rows_attributes => {
          0 => { :category_id => sale_categories[0].id, :amount => 100_000.00 }, # food
          1 => { :category_id => sale_categories[1].id, :amount =>  10_000.00 }, # beverage
          2 => { :category_id => sale_categories[2].id, :amount =>   1_000.00 }, # beer
          3 => { :category_id => sale_categories[3].id, :amount =>     100.00 }, # liquor
        },
        :vat =>                13_332.00,
        :service_charge =>        11_110,
        :settlement_type_sales_attributes => {
          0 => { :settlement_type_id => settlement_types[0].id, :amount => 98_345.00 },
          1 => { :settlement_type_id => settlement_types[1].id, :amount => 24_654.00 },
          2 => { :settlement_type_id => settlement_types[2].id, :amount =>    367.00 },
          3 => { :settlement_type_id => settlement_types[3].id, :amount =>  2_927.00 },
          4 => { :settlement_type_id => settlement_types[4].id, :amount =>    413.00 },
          5 => { :settlement_type_id => settlement_types[5].id, :amount =>     13.00 },
          6 => { :settlement_type_id => settlement_types[6].id, :amount =>       nil },
          7 => { :settlement_type_id => settlement_types[7].id, :amount =>       nil },
          8 => { :settlement_type_id => settlement_types[8].id, :amount =>       nil },
        },
        :gc_redeemed =>         1_000.00,
        :delivery_sales =>      7_823.00,
        :customer_count =>           489,
        :transaction_count =>        183,
        :sale_servers_attributes => {
          0 => { :server_id => servers[0].id, :amount => 100_000.00 },
          1 => { :server_id => servers[1].id, :amount =>   3_795.22 }
        },
        :cash_in_drawer =>     98_345.22,
        :gc_sales =>            5_000.00,
        :other_income =>          450.00,
      }
      @sale = Sale.new sale_params
    end

    it 'should compute total revenues' do
      @sale.total_revenues.should eq 135_542.00
    end

    it 'should compute net sales' do
      @sale.net_sales.should eq 111_100.00
    end

    it 'should compute total settlement type sales' do
      @sale.total_settlement_type_sales.should eq 135_542.00
    end

    it 'should compute server sale total' do
      @sale.server_sale_total.should eq 103_795.22
    end

    it 'should compute total cash for deposit' do
      @sale.cash_for_deposit.should eq 103_795.22
    end

    it 'should compute per person ave' do
      @sale.per_person_ave.should eq 227.20
    end

    it 'should compute per trans ave' do
      @sale.per_trans_ave.should eq 607.10
    end
  end
end
