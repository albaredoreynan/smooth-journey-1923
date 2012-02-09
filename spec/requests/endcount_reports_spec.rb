require 'spec_helper'

describe 'EndcountReport' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
    login_as(user)
  end

  context 'render as HTML' do
    before do
      # freeze time
      def Date.today
        Date.new(2012, 2, 6)
      end

      @item = FactoryGirl.create(:item)
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 1, :entry_date => Date.new(2011, 12, 31))
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 2, :entry_date => Date.new(2012,  1, 31))
      FactoryGirl.create(:item_count, :item => @item, :stock_count => 3, :entry_date => Date.new(2012,  2,  6))

      FactoryGirl.create(:purchase, :purchase_date => Date.new(2012, 2, 1), :purchase_items => [
        FactoryGirl.create(:purchase_item, :item => @item, :quantity => 1, :amount => 1, :unit => @item.unit)
      ])
    end

    context 'today' do
      before do
        visit '/reports/endcounts'
      end

      it 'should display the correct beginning count' do
        find("tr#endcount_item_#{@item.id} td:eq(4)").should have_content "2.0"
      end

      it 'should display the correct beginning total' do
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
      before do
        visit '/reports/endcounts?date[month]=1&date[year]=2012'
      end

      it 'should display the correct beginning count' do
        find("tr#endcount_item_#{@item.id} td:eq(4)").should have_content "1.0"
      end
    end
  end

  context 'render as CSV' do
    before do
      #@purchase_item = FactoryGirl.create(:purchase_item, :item => FactoryGirl.create(:item, :name => 'xxx'))
      visit '/reports/endcounts'
      click_link 'CSV'
    end

    it 'should have correct response header' do
      page.response_headers['Content-Type'].should =~ /csv/
      page.response_headers['Content-Disposition'].should =~ /attachment/
    end

    ['Item', 'Unit cost', 'Beginning count', 'Beginning total', 'Purchase',
      'Ending count', 'Ending total', 'COGS'].each do |head|
        it "should have a csv header \"#{head}\"" do
          page.should have_content head
        end
      end

    it 'should have a content' do
    end
  end
end
