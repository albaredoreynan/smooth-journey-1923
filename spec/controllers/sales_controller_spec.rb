require 'spec_helper'

describe SalesController do
  include Devise::TestHelpers

  before do
    @user = User.create!(:email => 'test@appsource.com', :password => 'password')
    sign_in @user

    @category = FactoryGirl.create(:category)
    @settlement_type = FactoryGirl.create(:settlement_type)
  end

  describe 'GET #index' do
    before do
      get 'new'
    end

    it 'should assign a new Sale' do
      assigns[:sale].should_not be_nil
      assigns[:sale].should be_kind_of(Sale)
      assigns[:sale].should be_new_record
    end

    it 'should assign all categories' do
      assigns[:category_names].should == [@category.name]
      assigns[:category_ids].should == [@category.id]
    end

    it 'should assign all settlement types' do
      assigns[:settlement_type_names].should == [@settlement_type.name]
      assigns[:settlement_type_ids].should == [@settlement_type.id]
    end
  end

  describe 'GET #edit' do
    before do
      @sale = FactoryGirl.create(:sale)
      get 'edit', :id => @sale.id
    end

    it 'should assign an existing Sale' do
      assigns[:sale].should == @sale
    end

    it 'should assign all categories' do
      assigns[:category_names].should == [@category.name]
    end
  end
end
