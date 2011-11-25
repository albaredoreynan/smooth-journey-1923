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
      @post_params = { conversion: { b_unit: 'kg', s_unit: 'g', conversion_number: 1000 } }
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
