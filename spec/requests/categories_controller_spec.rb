require 'spec_helper'

describe "Categories" do
  include Warden::Test::Helpers
  Warden.test_mode!

  before do
    user = FactoryGirl.create(:client_user)
  end

  after do
    Warden.test_reset!
  end
end
