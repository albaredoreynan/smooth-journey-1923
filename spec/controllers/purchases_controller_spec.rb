require 'spec_helper'
require 'cancan/matchers'

describe PurchasesController do
  context 'as admin' do
    login_admin

    describe "GET index" do
      context "Search" do
        before do
          @start_date = 5.days.ago
          @purchases = [
            FactoryGirl.create(:purchase, :purchase_date => @start_date ),
            FactoryGirl.create(:purchase, :purchase_date => Date.today)
          ]
        end

        it 'no match' do
          no_purchase_start_date = 1.year.ago
          get 'index',
            :start_date => no_purchase_start_date,
            :end_date => no_purchase_start_date + 1.day
          assigns[:purchases].should be_empty
        end

        it 'partial match' do
          get 'index',
            :start_date => @start_date.to_date,
            :end_date => (@start_date + 1.day).to_date
          assigns[:purchases].should eq [@purchases.first]
        end

        it 'should filter purchase by date' do
          get 'index', :start_date => @start_date.to_date, :end_date => Date.today.strftime('%F')
          assigns[:purchases].should eq [@purchases.last, @purchases.first]
        end

        it 'should filter purchase with start_date but without end_date' do
          get 'index', :start_date => @start_date.to_date, :end_date => ''
          assigns[:purchases].should eq [@purchases.last, @purchases.first]
        end

        it 'should filter purchase with end_date but without start_date' do
          get 'index', :start_date => '', :end_date => Date.today.strftime('%F')
          assigns[:purchases].should eq [@purchases.last, @purchases.first]
        end

        it 'should show all purchase without start_date and end_date' do
          get 'index', :start_date => '', :end_date => ''
          assigns[:purchases].should eq [@purchases.last, @purchases.first]
        end
      end

      it "should show all non-draft purchases" do
        purchase = FactoryGirl.create(:purchase, :save_as_draft => false)
        draft_purchase = FactoryGirl.create(:purchase, :save_as_draft => true)
        get 'index'
        assigns[:purchases].should eq [purchase]
      end
    end

    describe 'GET #new' do
      before do
        @purchase = FactoryGirl.create(:purchase)
        session.delete :purchase
      end

      it 'should create a new Purchase' do
        get 'new'
        assigns[:purchase].should be_kind_of(Purchase)
      end

      it 'should assign a purchase id on session' do
        get 'new'
        session[:purchase].should_not be_nil
      end

      it 'should restore a purchase' do
        session[:purchase] = @purchase.id
        get 'new'
        assigns[:purchase].should eq @purchase
      end

      it 'should reset purchase if purchase id was not found' do
        session[:purchase] = 'x'
        get 'new'
        response.should be_successful
      end
    end

    describe 'POST #create' do
      before do
        @purchase = FactoryGirl.create(:purchase)
        supplier = @purchase.supplier
        branch = @purchase.branch
        @post_params = { supplier_id: supplier.id, branch_id: branch.id }
      end

      after do
        session.delete :purchase
      end

      it 'should create a new Purchase' do
        session[:purchase].should be_nil
        lambda {
          post :create, :purchase => @post_params
        }.should change(Purchase, :count).by(1)
      end

      it 'should restore a Purchase' do
        session[:purchase] = @purchase.id
        lambda {
          post :create, :purchase => @post_params
        }.should_not change(Purchase, :count)
        assigns[:purchase].should eq @purchase
      end

      it 'should load its purchase item' do
        session[:purchase] = @purchase.id
        @purchase_item = FactoryGirl.create(:purchase_item, :purchase => @purchase)
        post :create, :purchase => @post_params
        assigns[:purchase].purchase_items.should eq [@purchase_item]
      end

      it 'should set purchase as non-draft' do
        @purchase.update_attribute(:save_as_draft, true)
        session[:purchase] = @purchase.id
        post :create, :purchase => @post_params
        @purchase.reload.save_as_draft.should eq false
      end
    end

    describe 'PUT #update' do
      before do
        @purchase = FactoryGirl.create(:purchase)
        branch = @purchase.branch
        supplier = @purchase.branch
        @put_params = { :supplier_id => supplier.id, :branch_id => branch.id }
      end

      after do
        session.delete :purchase
      end

      it 'should set purchase as non-draft' do
        @purchase.update_attribute(:save_as_draft, true)
        session[:purchase] = @purchase.id
        put 'update', :id => @purchase.id, :purchase => @put_params
        @purchase.reload.save_as_draft.should eq false
      end

      it 'should clear the purchase session' do
        session[:purchase] = @purchase.id
        put 'update', :id => @purchase.id, :purchase => @put_params
        session[:purchase].should be_nil
      end
    end

  end

  context 'as branch manager' do
    login_branch

    before do
      @company = @current_branch.company
      @company.update_attribute(:settings, { :enable_lock_module => true, :lock_module_in => 1440 })
    end

    context 'GET #index' do
      it 'should load all purchase from the branch' do
        @purchase = FactoryGirl.create(:purchase, :branch => @current_branch)
        FactoryGirl.create(:purchase)
        get 'index'
        assigns[:purchases].should eq [@purchase]
      end
    end

    context 'GET #show' do
      it 'should only show its own purchase' do
        purchase = FactoryGirl.create(:purchase)
        get 'show', :id => purchase.to_param
        response.should redirect_to root_url
      end
    end

    context 'GET #new' do
      it 'should set its own branch' do
        get 'new'
        assigns[:purchase].branch_id.should eq @current_branch.id
      end
    end

    context 'POST #create' do
      it 'should set its branch' do
        purchase = FactoryGirl.create(:purchase, :branch => @current_branch)
        session[:purchase] = purchase.id
        post_params = FactoryGirl.attributes_for(:purchase, :branch_id => nil)
        post 'create', :purchase => post_params
        purchase.branch.should eq @current_branch
      end
    end

    context 'PUT #update' do
      it 'should allow update purchase when draft' do
        purchase = FactoryGirl.create(:purchase, :branch => nil, :save_as_draft => true)
        ability = Ability.new(@current_user)
        ability.should be_able_to(:update, purchase)
      end

      it 'should not allow update purchase when no branch' do
        purchase = FactoryGirl.create(:purchase, :branch => nil, :save_as_draft => false)
        ability = Ability.new(@current_user)
        ability.should_not be_able_to(:update, purchase)
      end

      it 'should be able to update a purchase' do
        purchase = FactoryGirl.create(:purchase, :branch => nil, :save_as_draft => true)
        put_params = FactoryGirl.attributes_for(:purchase, :invoice_number => '333')
        lambda {
          put 'update', :id => purchase.to_param, :purchase => put_params
        }.should change{purchase.reload.invoice_number}.to('333')
      end

      it 'should not change its branch' do
        purchase = FactoryGirl.create(:purchase, :branch => @current_branch)
        branch = FactoryGirl.create(:branch)
        put_params = FactoryGirl.attributes_for(:purchase, :branch_id => branch.to_param)
        lambda {
          put 'update', :id => purchase.to_param, :purchase => put_params
        }.should_not change{purchase.reload.branch_id}
      end

      it 'should not be able to edit other purchase' do
        other_branch = FactoryGirl.create(:branch)
        purchase = FactoryGirl.create(:purchase, :branch => other_branch)
        put_params = FactoryGirl.attributes_for(:purchase, :invoice_number => '555')
        lambda {
          put 'update', :id => purchase.to_param, :purchase => put_params
        }.should_not change{purchase.reload.invoice_number}.to('555')
      end

      it 'should be able to update purchase before lock' do
        @company.settings.merge!(:lock_module_in => 180)
        purchase = FactoryGirl.create(:purchase, :branch => @current_branch, :created_at => 2.hour.ago)
        put_params = FactoryGirl.attributes_for(:purchase, :invoice_number => '2323')
        lambda {
          put 'update', :id => purchase.to_param, :purchase => put_params
        }.should change{purchase.reload.invoice_number}
      end

      it 'should not be able to update purchase after locked' do
        purchase = FactoryGirl.create(:purchase, :branch => @current_branch, :created_at => 5.days.ago)
        put_params = FactoryGirl.attributes_for(:purchase, :invoice_number => '2323')
        lambda {
          put 'update', :id => purchase.to_param, :purchase => put_params
        }.should_not change{purchase.reload.invoice_number}
      end
    end
  end
end
