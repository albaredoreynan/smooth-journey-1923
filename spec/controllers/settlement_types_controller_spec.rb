require 'spec_helper'

describe SettlementTypesController do
  login_user

  context 'GET #index' do
    before do
      @settlement_type = FactoryGirl.create(:settlement_type)
      get 'index'
    end

    it 'should load all settlement type' do
      assigns[:settlement_types].should eq [@settlement_type]
    end
  end

  context 'POST #create' do
    before do
      @post_params = { settlement_type: { name: 'Cash' } }
    end

    it 'should redirect to #index' do
      post 'create', @post_params
      response.should redirect_to settlement_types_path
    end

    it 'should save a settlement type' do
      lambda {
        post 'create', @post_params
      }.should change(SettlementType, :count).by 1
    end
  end
end
