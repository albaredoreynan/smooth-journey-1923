require 'spec_helper'

describe PurchaseItemsController do
  login_user

  context 'POST #create' do
    before do
      @purchase = FactoryGirl.create(:purchase)
      @post_params = { :item_id => 1, :amount => 10, :quantity => 1 }
    end

    it 'should assign a purchase' do
      post :create, :purchase_id => @purchase.to_param
      assigns[:purchase].should eq @purchase
    end

    it 'should render a form without layout' do
      post :create, :purchase_id => @purchase.to_param, :purchase_item => @post_params
      response.should render_template('purchase_items/create')
    end
  end
end
