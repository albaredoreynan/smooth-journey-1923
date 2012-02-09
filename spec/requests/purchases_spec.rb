require 'spec_helper'

describe "Purchases" do
  include Warden::Test::Helpers
  Warden.test_mode!

  after do
    Warden.test_reset!
  end

  context 'as client user' do
    before do
      user = FactoryGirl.create(:client_user)
      login_as(user)

      @company = user.companies.first
      @restaurant = FactoryGirl.create(:restaurant, :company => @company)
      FactoryGirl.create(:branch, :location => 'my branch', :restaurant => @restaurant)
    end

    it 'should add new purchase' do
      visit '/purchases'
      click_link 'New purchase'

      fill_in :date, :with => '2011-01-01'
      select 'my branch', :from => 'Branch'

      click_on 'Update Purchase'
    end

    it 'new purchase with purchase item' do
      visit '/purchases'
      click_link 'New purchase'
    end
  end
end
