require 'spec_helper'

describe PurchaseItemsController do
  login_user

  describe 'when successful' do
    context 'POST #create' do
      before do
        @purchase = FactoryGirl.create(:purchase)
        @item = FactoryGirl.create(:item)
        @post_params = { :item_id => @item.id, :unit_id => @item.unit.id,
          :amount => 10, :quantity => 1, :vat_type => 'VAT-Inclusive' }
      end

      it 'should assign a purchase' do
        post :create, :purchase_id => @purchase.to_param
        assigns[:purchase].should eq @purchase
      end

      it 'should render a form without layout' do
        post :create, :purchase_id => @purchase.to_param, :purchase_item => @post_params
        response.should render_template('purchases/_form')
      end

      it 'should save a purchase item' do
        lambda {
          post :create, :purchase_id => @purchase.to_param, :purchase_item => @post_params
        }.should change(PurchaseItem, :count).by(1)
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

      it 'should render a destroy.js' do
        xhr :delete, :destroy, :purchase_id => @purchase.id, :id => @purchase_item.id
        response.should render_template('purchase_items/destroy')
      end
    end
  end
end
