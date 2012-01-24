class UsersController < ApplicationController

  def index
    if current_user.client?
      @users = User.where('users.id != ?', current_user.id).filter_by_company(current_company.id)
    else
      @users = User.where('users.id != ?', current_user.id)
    end
  end

  def destroy
  end
end
