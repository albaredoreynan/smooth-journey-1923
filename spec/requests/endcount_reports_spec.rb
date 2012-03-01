require 'spec_helper'

describe 'EndcountReport' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
    login_as(user)
  end

  after do
    Warden.test_reset!
  end

  context 'render as HTML' do
    before do
      @item = FactoryGirl.create(:item)
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 1, :entry_date => 2.months.ago.end_of_month.to_date)
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 2, :entry_date => 1.months.ago.end_of_month.to_date)
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 3, :entry_date => Date.today)

      FactoryGirl.create(:purchase, :purchase_date => Date.today.beginning_of_month.to_date, :purchase_items => [
        FactoryGirl.create(:purchase_item, :item => @item, :quantity => 1, :amount => 1, :unit => @item.unit)
      ])
    end

    context 'today' do
      before do
        visit '/reports/endcounts'
      end

      it 'should display the correct beginning count', :slow => true do
        find("tr#endcount_item_#{@item.id} td:eq(4)").should have_content "2.0"
      end

      it 'should display the correct beginning total', :slow => true do
        find("tr#endcount_item_#{@item.id} td:eq(5)").should have_content "2.00"
      end

      it 'should display the correct purchase amount' do
        find("tr#endcount_item_#{@item.id} td:eq(6)").should have_content "1.00"
      end

      it 'should display the correct ending count' do
        find("tr#endcount_item_#{@item.id} td:eq(7)").should have_content "3.0"
      end

      it 'should display the correct ending total' do
        find("tr#endcount_item_#{@item.id} td:eq(8)").should have_content "3.0"
      end
    end

    context 'previous month' do
      it 'should display the correct beginning count' do
        previous_month = 1.months.ago
        visit "/reports/endcounts?date[month]=#{previous_month.month}&date[year]=#{previous_month.year}"
        find("tr#endcount_item_#{@item.id} td:eq(4)").should have_content "1.0"
      end
    end
  end

  context 'render as CSV' do
    before do
      visit '/reports/endcounts'
      click_link 'CSV'
    end

    it 'should have correct response header' do
      page.response_headers['Content-Type'].should =~ /csv/
      page.response_headers['Content-Disposition'].should =~ /attachment/
    end
  end
end
