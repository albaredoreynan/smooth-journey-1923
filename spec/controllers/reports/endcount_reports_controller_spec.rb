require 'spec_helper'

describe Reports::EndcountReportsController do
  context 'as client user' do
    login_client

    context 'GET #index' do
      before do
        @restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        @branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
        @item = FactoryGirl.create(:item, :restaurant => @restaurant)
        @item_counts = [
          FactoryGirl.create(:item_count, :branch => @branch, :item => @item, :stock_count =>   5, :entry_date => 5.months.ago.beginning_of_month - 1.day),
          FactoryGirl.create(:item_count, :branch => @branch, :item => @item, :stock_count => 7.5, :entry_date => 5.months.ago),
          FactoryGirl.create(:item_count, :branch => @branch, :item => @item, :stock_count =>  10, :entry_date => 5.months.ago.end_of_month),
          FactoryGirl.create(:item_count, :branch => @branch, :item => @item, :stock_count =>  30, :entry_date => Date.today.beginning_of_month - 1.day),
          FactoryGirl.create(:item_count, :branch => @branch, :item => @item, :stock_count =>  40, :entry_date => Date.today)
        ]
      end

      it 'should return endcount' do
        get 'index'
        assigns[:endcount].should be_instance_of Endcount
      end

      it 'should contain endcount item' do
        get 'index'
        assigns[:endcount].items.each do |e|
          e.should be_instance_of EndcountItem
        end
      end

      it 'should get the correct beginning count' do
        get 'index'
        assigns[:endcount].items[0].beginning_count.should eq 30
      end

      it 'should get the correct ending count' do
        get 'index'
        assigns[:endcount].items[0].ending_count.should eq 40
      end

      it 'should default ending_date today when current month' do
        today = Date.today
        get 'index', :date => { :month => today.month, :year => today.year }
        assigns[:ending_date].should eq today
      end

      context "previous months" do
        before do
          @view_month = 5.months.ago
        end

        it "should get endcount's beginning_count from previous month" do
          get 'index', :date => { :month => @view_month.month, :year => @view_month.year }
          assigns[:endcount].items[0].beginning_count.should eq 5
        end

        it 'should ending_date to end_of_month' do
          get 'index', :date => { :month =>  @view_month.month, :year => @view_month.year }
          assigns[:ending_date].should eq @view_month.end_of_month.to_date
        end

        it "should get endcount's ending_count from previous month" do
          get 'index', :date => { :month => @view_month.month, :year => @view_month.year }
          assigns[:endcount].items[0].ending_count.should eq 10
        end

        it 'should get total purchases amount from beginning to ending date' do
          pending
          branch = FactoryGirl.create(:branch, :restaurant => @restaurant)
          FactoryGirl.create(:purchase_item,
                            :item => @item, :amount => 1, :quantity => 1, :unit => @item.unit,
                            :purchase => FactoryGirl.create(:purchase, :branch => branch, :purchase_date => @view_month))
          FactoryGirl.create(:purchase_item,
                            :item => @item, :amount => 1, :quantity => 1, :unit => @item.unit,
                            :purchase => FactoryGirl.create(:purchase, :branch => branch, :purchase_date => @view_month + 1.day))
          get 'index', :date => { :month => @view_month.month, :year => @view_month.year}
          assigns[:endcount].items[0].purchase_amount_period.should eq 2.0
        end
      end
    end
  end

  context 'as branch user' do
    login_branch

    it 'should only show purchases of branch' do
      item = FactoryGirl.create(:item, :restaurant => @current_branch.restaurant)
      FactoryGirl.create(:purchase_item, :item => item, :amount => 4, :unit => item.unit,
                         :purchase => FactoryGirl.create(:purchase, :branch => @current_branch))
      get 'index'
      assigns[:endcount].items[0].purchase_amount_period.should eq 4
    end
  end
end
