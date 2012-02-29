require 'spec_helper'

describe SuppliersController do
  context 'as client' do
    login_client

    context 'GET #index' do
      it 'should load clients suppliers' do
        supplier = FactoryGirl.create(:supplier, :company => @current_company)
        get 'index'
        assigns[:suppliers].should eq [supplier]
      end
    end

    context 'POST #create' do
      it 'should set company by system' do
        post_params = FactoryGirl.attributes_for(:supplier).merge(:name => 'SupplierXXX', :company_id => nil)
        post 'create', :supplier => post_params
        supplier = Supplier.find_by_name('SupplierXXX')
        supplier.company.should eq @current_company
      end
    end

    context 'PUT #update' do
      before do
        @put_params = { :name => 'ABC' }
      end

      it 'should update supplier' do
        supplier = FactoryGirl.create(:supplier, :company => @current_company)
        lambda {
          put 'update', :id => supplier.id, :supplier => @put_params
        }.should change{supplier.reload.name}.to('ABC')
      end

      it 'should NOT be able to update other supplier' do
        supplier = FactoryGirl.create(:supplier)
        lambda {
          put 'update', :id => supplier.id, :supplier => @put_params
        }.should_not change{supplier.reload.name}
      end
    end
  end

  context 'as branch user' do
    login_branch

    context 'GET #index' do
      it 'should only show supplier within the company' do
        supplier = FactoryGirl.create(:supplier, :company => @current_company)
        FactoryGirl.create(:supplier) # other supplier
        get 'index'
        assigns[:suppliers].should eq [supplier]
      end
    end
  end
end
