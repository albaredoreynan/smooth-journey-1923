require 'spec_helper'

describe CompaniesController do
  context 'as client user' do
    login_client

    context 'GET #index' do
      before do
        get 'index'
      end

      it 'should load all companies' do
        assigns[:companies].should eq [@current_company]
      end
    end

    context 'POST #create' do
      before do
        @post_params = { company: { name: 'Company X' } }
      end

      it 'should save a company' do
        lambda {
          post 'create', @post_params
        }.should_not change(Company, :count).by 1
      end
    end
  end
end
