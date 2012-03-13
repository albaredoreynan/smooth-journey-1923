require 'spec_helper'

describe DirectionalController do

  context 'GET #index' do
    it 'should instantiate directional' do
      pending
      get 'index'
      assigns[:directional].should be_instance_of Directional
    end
  end
end
