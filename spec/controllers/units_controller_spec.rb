require 'spec_helper'

describe UnitsController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end
  
  context 'GET #index' do
    before do
      get 'index'
      @unit = FactoryGirl.create(:unit)
    end
    
    it 'should load all units' do
      assigns[:units].should eq [@unit]
    end
  end
end
