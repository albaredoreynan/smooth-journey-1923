require 'spec_helper'

describe Reports::EndcountReportsController do
  context 'as admin' do
    login_admin

    context 'GET #index' do
      before do
        @item = FactoryGirl.create(:item)
        @item_counts = [
          FactoryGirl.create(:item_count, :item => @item, :stock_count =>   5, :entry_date => 5.months.ago.beginning_of_month - 1.day),
          FactoryGirl.create(:item_count, :item => @item, :stock_count => 7.5, :entry_date => 5.months.ago),
          FactoryGirl.create(:item_count, :item => @item, :stock_count =>  10, :entry_date => 5.months.ago.end_of_month),
          FactoryGirl.create(:item_count, :item => @item, :stock_count =>  30, :entry_date => Date.today.beginning_of_month - 1.day),
          FactoryGirl.create(:item_count, :item => @item, :stock_count =>  40, :entry_date => Date.today)
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

      it "should get endcount's beginning_count from previous month" do
        view_month = 5.months.ago
        get 'index', :month => view_month.month, :year => view_month.year
        assigns[:endcount].items[0].beginning_count.should eq 5
      end

      it "should get endcount's ending_count from previous month" do
        view_month = 5.months.ago
        get 'index', :month => view_month.month, :year => view_month.year
        assigns[:endcount].items[0].ending_count.should eq 10
      end
    end
  end
end
