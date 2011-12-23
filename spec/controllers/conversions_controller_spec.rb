require 'spec_helper'

describe ConversionsController do
  login_user

  before do
    @bigger_unit = FactoryGirl.create(:unit, :name => 'kg')
    @smaller_unit = FactoryGirl.create(:unit, :name => 'g')
  end

  context 'GET #index' do
    it 'should load all conversions' do
      @conversion = FactoryGirl.create(:conversion)
      get 'index'
      assigns[:conversions].should eq [@conversion]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { conversion: {
        bigger_unit_id: @bigger_unit.to_param,
        smaller_unit_id: @smaller_unit.to_param,
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

  context 'PUT #update' do
    before do
      @conversion = FactoryGirl.create(:conversion)
      @put_params = {
        :bigger_unit_id => @bigger_unit.to_param,
        :smaller_unit_id => @smaller_unit.to_param,
        :conversion_factor => 90
      }
    end

    it 'should redirect to #index' do
      put 'update', :id => @conversion.to_param, :conversion => @put_params
      response.should redirect_to conversions_path
    end
  end

end
