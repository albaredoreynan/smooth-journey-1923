module ControllerMacros
  def login_user
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:user)
      sign_in @current_user
    end
  end

  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:admin_user)
      sign_in @current_user
    end
  end

  def login_branch
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user= FactoryGirl.create(:branch_user)
      sign_in @current_user
    end
  end
end
