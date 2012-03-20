require 'spec_helper'

describe ServersController do
  context 'as client' do
    login_client

    before do
      restaurant = FactoryGirl.create(:restaurant, :company => @current_company)
      @branch = FactoryGirl.create(:branch, :restaurant => restaurant)
    end

    context 'GET #index' do
      before do
        @server = FactoryGirl.create(:server, :branch => @branch)
        FactoryGirl.create(:server) # other server
      end

      it "should show client's server" do
        get 'index'
        assigns[:servers].should eq [@server]
      end
    end

    context 'POST #create' do
      before do
        @post_params = { :server => { :branch_id => @branch.id, :name => 'Cash' } }
      end

      it 'should redirect to #index' do
        post 'create', @post_params
        response.should redirect_to servers_path
      end

      it 'should save a server' do
        lambda {
          post 'create', @post_params
        }.should change(Server, :count).by 1
      end
    end
  end

  context 'as branch' do
    login_branch

    context 'GET #index' do
      it 'should show server from branch' do
        @server = FactoryGirl.create(:server, :branch => @current_branch)
        FactoryGirl.create(:server) # other server
        get 'index'
        assigns[:servers].should eq [@server]
      end
    end
  end
end
