require 'spec_helper'

describe SettingsController do
  context 'as client' do
    login_client

    context 'GET #index' do
      it 'should set company' do
        get 'index'
        assigns[:company].should be_instance_of Company
      end

      it 'should be able to show setting' do
        get 'index'
        response.should be_successful
      end
    end

    context 'PUT #update' do
      it 'should be able to update setting' do
        lambda {
          put 'update', :company => { :settings => { :enable_lock_module => true, :lock_module_in => 25 } }
        }.should change{@current_company.reload.settings}
      end
    end
  end
end
