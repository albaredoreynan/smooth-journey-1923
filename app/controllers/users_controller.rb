class UsersController < ApplicationController
  
  def index
    if current_user.client?
      @users = User.where('users.id != ?', current_user.id).filter_by_company(current_company.id)
    else
      @users = User.where('users.id != ?', current_user.id)
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to(users_path, :notice => 'User was successfully created.')
    else
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
 
end
