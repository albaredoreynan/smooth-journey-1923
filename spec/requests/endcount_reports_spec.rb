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
      @base_unit = FactoryGirl.create(:unit, :name => 'base')
      @to_unit = FactoryGirl.create(:unit, :name => 'to')
      FactoryGirl.create(:conversion, :bigger_unit => @to_unit, :smaller_unit => @base_unit, :conversion_factor => 2)
      @item = FactoryGirl.create(:item, :unit => @base_unit)
      @purchase_item = FactoryGirl.create(:purchase_item, :item => @item, :quantity => 10, :unit => @to_unit)
    end

    it 'should a page title' do
      visit '/reports/endcounts'
      page.should have_content "Item Cost Analysis"
    end

    it 'should display the correct unit cost' do
      visit '/reports/endcounts'

      # find Unit cost column
      unit_cost_column = "tr#endcount_item_#{@item.id} td:eq(2)"
      find(unit_cost_column).should have_content '0.05'
    end

    it 'should display the correct unit' do
      visit '/reports/endcounts'

      # find Unit column
      unit_column = "tr#endcount_item_#{@item.id} td:eq(3)"
      find(unit_column).should have_content @base_unit.name
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
