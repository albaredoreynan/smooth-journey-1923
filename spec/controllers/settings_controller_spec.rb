require 'spec_helper'

describe SettingsController do
  context 'as client' do
    login_client

    context 'GET #index' do
      it 'should set company' do
        get 'index'
        assigns[:company].should be_instance_of Company
      end

      it 'should be able to show settings' do
        get 'index'
        response.should be_successful
      end
    end

    context 'PUT #update' do
      it 'should be able to company settings' do
        lambda {
          put 'update', :company => { :settings => { :enable_lock_module => true, :lock_module_in => 25 } }
        }.should change{@current_company.reload.settings}
      end

      it 'should store the correct data type' do
        put 'update', :company => { :settings => { :enable_lock_module => '1', :lock_module_in => '25' } }
        settings = @current_company.reload.settings
        settings[:enable_lock_module].should be_kind_of TrueClass
      end
    end
  end
end
