require 'spec_helper'

describe 'PurchaseReport' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
    login_as(user)

    @purchase_item = FactoryGirl.create(:purchase_item, :item => FactoryGirl.create(:item, :name => 'xxx'))

    visit '/reports/purchases'
  end

  context 'render as HTML' do
    it 'should a page title' do
      page.should have_content "Purchase Reports"
    end
  end

  context 'render as CSV' do
    before do
      click_link 'CSV'
    end

    it 'should have correct response header' do
      page.response_headers['Content-Type'].should =~ /csv/
      page.response_headers['Content-Disposition'].should =~ /attachment/
    end

    it 'should have a csv header' do
      page.should have_content 'Item, Invoice number, Supplier name, Purchase date'
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
