require 'spec_helper'

describe UnitsController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user
  end
  
  context 'GET #index' do
    before do
      @unit = FactoryGirl.create(:unit)
    end
    
    it 'should load all units' do
      get 'index'
      assigns[:units].should eq [@unit]
    end
    
    it 'should search a unit' do
      @unit2 = FactoryGirl.create(:unit, :name => 'lbs')
      get 'index', :search => 'lbs'
      assigns[:units].should eq [@unit2]
    end
  end
end
