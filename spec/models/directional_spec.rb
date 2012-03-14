require 'spec_helper'

describe Directional do
  before do
    @branch = FactoryGirl.create(:branch)
    @sales = [
      FactoryGirl.create(:sale, :branch => @branch, :customer_count => 10, :transaction_count => 30),
      FactoryGirl.create(:sale, :branch => @branch, :customer_count => 20, :transaction_count => 40)
    ]

    @sale_categories = [
      FactoryGirl.create(:sale_category, :name => 'Food'),
      FactoryGirl.create(:sale_category, :name => 'Beverage')
    ]

    @sale_cat_rows = [
      FactoryGirl.create(:sale_category_row, :amount =>  5_000, :sale => @sales[0], :category => @sale_categories[0]),
      FactoryGirl.create(:sale_category_row, :amount =>  5_000, :sale => @sales[0], :category => @sale_categories[0]),
      FactoryGirl.create(:sale_category_row, :amount => 20_000, :sale => @sales[1], :category => @sale_categories[1])
    ]
    @directional = Directional.new(Date.today.beginning_of_month, Date.today, @branch.id)
  end

  context '.net_sales' do
    it 'should get total from key' do
      @directional.net_sale_total.should eq 30_000
    end

    it 'should include totals by categories' do
      @directional.net_sales.should include('Food' => 10_000)
      @directional.net_sales.should include('Beverage' => 20_000)
    end
  end

  context '.customer_count' do
    it 'should get its total' do
      @directional.customer_count.should eq 30
    end
  end

  context '.per_person_average' do
    it 'should get its total' do
      @directional.per_person_ave.should eq 2000.00
    end
  end

  context '.transaction_count' do
    it 'should get its total' do
      @directional.transaction_count.should eq 70
    end
  end

  context '.per_trans_ave' do
    it 'should get its total' do
      @directional.per_trans_ave.should eq 833.33
    end
  end
end
