require 'spec_helper'

describe PurchaseItemsController do
  login_user

  describe 'when successful' do
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
        response.should render_template('purchases/_form')
      end
    end

    context 'DELETE #destroy' do
      before do
        @purchase_item = FactoryGirl.create(:purchase_item)
        @purchase = @purchase_item.purchase
      end

      it 'should be successful' do
        delete :destroy, :purchase_id => @purchase.id, :id => @purchase_item.id
        response.should be_successful
      end
    end
  end
end
