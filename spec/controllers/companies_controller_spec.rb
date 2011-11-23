require 'spec_helper'

describe CompaniesController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end

  context 'GET #index' do
    before do
      @company = FactoryGirl.create(:company)
      get 'index'
    end

    it 'should load all companies' do
      assigns[:companies].should eq [@company]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { company: { name: 'Company X' } }
    end

    it 'should redirect to #index' do
      post 'create', @post_params
      response.should redirect_to companies_path
    end

    it 'should save a company' do
      lambda {
        post 'create', @post_params
      }.should change(Company, :count).by 1
    end
  end
end
