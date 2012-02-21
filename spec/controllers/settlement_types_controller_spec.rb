require 'spec_helper'

describe SettlementTypesController do
  context 'as client' do
    login_client

    before do
      restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      @branch = FactoryGirl.create(:branch, :restaurant => restaurant)
    end

    context 'GET #index' do
      before do
        @settlement_type = FactoryGirl.create(:settlement_type, :branch => @branch)
        get 'index'
      end

      it "should show client's settlement type" do
        FactoryGirl.create(:settlement_type) # other settlement type
        assigns[:settlement_types].should eq [@settlement_type]
      end
    end

    context 'POST #create' do
      before do
        @post_params = { :settlement_type => { :branch_id => @branch.id, :name => 'Cash' } }
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
end
