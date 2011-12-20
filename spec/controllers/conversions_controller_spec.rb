require 'spec_helper'

describe ConversionsController do
  login_user

  context 'GET #index' do
    before do
      @conversion = FactoryGirl.create(:conversion)
      get 'index'
    end

    it 'should load all conversions' do
      assigns[:conversions].should eq [@conversion]
    end
  end

  context 'POST #create' do
    before do
      bigger_unit = FactoryGirl.create(:unit, :name => 'kg')
      smaller_unit = FactoryGirl.create(:unit, :name => 'g')
      @post_params = { conversion: {
        bigger_unit_id: bigger_unit.to_param,
        smaller_unit_id: smaller_unit.to_param,
        conversion_factor: 1000 } }
    end

    it 'should redirect to #index' do
      post 'create', @post_params
      response.should redirect_to conversions_path
    end

    it 'should save a conversion' do
      lambda {
        post 'create', @post_params
      }.should change(Conversion, :count).by 1
    end
  end

end
