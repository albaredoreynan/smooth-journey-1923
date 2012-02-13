require 'spec_helper'

describe 'PurchaseReport' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
    login_as(user)

    @base_unit = FactoryGirl.create(:unit, :name => 'base')
    @to_unit = FactoryGirl.create(:unit, :name => 'to')
    FactoryGirl.create(:conversion, :bigger_unit => @to_unit, :smaller_unit => @base_unit, :conversion_factor => 2)
    @item = FactoryGirl.create(:item, :unit => @base_unit)
    @purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :quantity => 10, :unit => @to_unit)

    visit '/reports/purchases'
  end

  after do
    Warden.test_reset!
  end

  context 'render as HTML' do
    before do
      @cols = { :quantity => 6, :unit => 7, :unit_cost => 8 }
      def self.item_column_finder(col)
        find("tr#item_#{@item.id} td:eq(#{col})")
      end
    end

    it 'should a page title' do
      page.should have_content "Purchase Reports"
    end

    it 'should display the converted quantity' do
      item_column_finder(@cols[:quantity]).should have_content '20'
    end

    it 'should display the items base unit' do
      item_column_finder(@cols[:unit]).should have_content @item.unit.name
    end

    it 'should display the converted unit cost' do
      item_column_finder(@cols[:unit_cost]).should have_content '0.05'
    end
  end

  context 'render as CSV' do
    before do
      item = FactoryGirl.create(:item, :name => 'xxx')
      @purchase_item = FactoryGirl.create(:purchase_item, :item => item, :unit => item.unit)
      visit '/reports/purchases'

      click_link 'CSV'
    end

    it 'should have correct response header' do
      page.response_headers['Content-Type'].should =~ /csv/
      page.response_headers['Content-Disposition'].should =~ /attachment/
    end

    it 'should have a content' do
      page.should have_content 'xxx'
    end
  end

  context 'render as PDF' do
    before do
      click_link 'PDF'
    end

    it 'should have correct response header' do
      page.response_headers['Content-Type'].should =~ /pdf/
      page.response_headers['Content-Disposition'].should =~ /attachment/
    end
  end
end
