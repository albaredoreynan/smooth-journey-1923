require 'spec_helper'

describe UnitsController do
  context 'as admin' do
    login_admin

    context 'GET #index' do
      before do
        @unit = FactoryGirl.create(:unit)
      end

      it 'should load all units' do
        get 'index'
        assigns[:units].should eq [@unit]
      end

      it 'should search a unit' do
        @unit2 = FactoryGirl.create(:unit, :symbol => 'lbs')
        get 'index', :search => 'lbs'
        assigns[:units].should eq [@unit2]
      end
    end

    context 'POST #create' do
      before do
        @post_params = { unit: { symbol: 'N', name: 'Newton' } }
      end

      it 'should redirect to #index' do
        post 'create', @post_params
        response.should redirect_to units_path
      end

      it 'should save a unit' do
        lambda {
          post 'create', @post_params
        }.should change(Unit, :count).by(1)
      end
    end

    context 'PUT #update' do
      before do
        @unit = FactoryGirl.create(:unit, :symbol => 'k')
        @put_params = { :symbol => 'kg', :name => 'Kilogram' }
      end

      it 'should redirect to #index' do
        put 'update', :id => @unit.id, :unit => @put_params
        response.should redirect_to(units_path)
      end
    end
  end

  context 'as client user' do
    login_client

    context 'GET #index' do
      before do
        restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
        @unit = FactoryGirl.create(:unit, :restaurant => restaurant)
      end

      it 'should only view units from its own company' do
        FactoryGirl.create(:unit)
        get 'index'
        assigns[:units].should eq [ @unit ]
      end
    end
  end
end
