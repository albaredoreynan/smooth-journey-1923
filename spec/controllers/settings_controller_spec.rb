require 'spec_helper'

describe SettingsController do
  context 'as client' do
    login_client

    context 'GET #index' do
      it 'should automatically create a setting if does not exists' do
        get 'index'
        assigns[:setting].should be_instance_of Setting
      end

      it 'should be able to show setting' do
        get 'index'
        response.should be_successful
      end

      it "should load company's setting" do
        @setting = FactoryGirl.create(:setting, company: @current_company)
        get 'index'
        @current_company.should eq @setting.company
        assigns[:setting].should eq @setting
      end
    end

    context 'PUT #update' do
      it 'should be able to update setting' do
        lambda {
          put 'update', setting: { enable_lock_module: true, lock_module_in: 25 }
        }.should change(Setting, :count).by(1)
      end
    end
  end
end
