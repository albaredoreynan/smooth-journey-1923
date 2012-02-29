require 'spec_helper'

describe 'DeviseController' do

  describe 'sign up' do
    it 'should be able to sign up' do
      visit '/users/sign_up'

      fill_in 'Username', :with => 'testuser'
      fill_in 'Email', :with => 'testuser@example.com'
      fill_in 'Password', :with => 'password'
      fill_in 'Password confirmation', :with => 'password'

      click_on 'Sign up'

      page.should have_content 'You have signed up successfully.'
    end
  end
end
