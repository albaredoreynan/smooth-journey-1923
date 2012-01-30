require 'spec_helper'

describe 'EndcountReport' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
    login_as(user)
  end

  context 'render as HTML' do
    it 'should a page title' do
      visit '/reports/endcounts'
      page.should have_content "Item Cost Analysis"
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
