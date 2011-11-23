require 'spec_helper'

describe CurrenciesController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end

  context 'GET #index' do
    before do
      @currency = FactoryGirl.create(:currency)
      get 'index'
    end

    it 'should load all currencies' do
      assigns[:currencies].should eq [@currency]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { currency: { currency: 'Dollar', symbol: '$' } }
    end

    it 'should redirect to #index' do
      post 'create', @post_params
      response.should redirect_to currencies_path
    end

    it 'should save a currency' do
      lambda {
        post 'create', @post_params
      }.should change(Currency, :count).by 1
    end
  end
end
