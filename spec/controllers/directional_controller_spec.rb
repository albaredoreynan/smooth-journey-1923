require 'spec_helper'

describe DirectionalController do

  context 'as client' do
    context 'GET #index' do
      login_client

      it 'should instantiate directional' do
        get 'index'
        assigns[:directional].should be_instance_of Directional
      end
    end
  end
end
