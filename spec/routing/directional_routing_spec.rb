require 'spec_helper'

describe DirectionalController do
  context' routing' do
    it 'should route to directional' do
      { :get => '/directional' }.should route_to(:controller => 'directional', :action => 'index')
    end
  end
end
