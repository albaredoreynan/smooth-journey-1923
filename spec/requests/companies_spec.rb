require 'spec_helper'

describe "Companies" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:admin_user)
    login_as(user)

    @company = FactoryGirl.create(:company, :name => 'Company X')
  end

  after do
    Warden.test_reset!
  end

  describe "GET /companies" do
    it "should show all companies" do
      visit '/companies'
      within_table('companies') do
        page.should have_content('Company X')
      end
    end

    it 'should have dom id for each company row' do
      visit '/companies'
      page.should have_selector("table#companies tr#company_#{@company.id}")
    end
  end

  describe 'POST /companies' do
    it 'should add new company' do
      visit '/companies'
      click_link 'New Company'

      fill_in 'Name', :with => 'company y'
      click_button 'Create Company'
    end
  end

  describe 'PUT /companies' do
    it 'should edit a company' do
      visit '/companies'
      find("tr#company_#{@company.id}").click_link('Edit')

      fill_in 'Name', :with => 'New company'
      fill_in 'Address', :with => '123 Acasia St. Ortigas Pasay City'
      fill_in 'Contact number', :with => '900-00-00'

      click_button 'Update Company'
      page.should have_content('New company')
    end
  end
end
