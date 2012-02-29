class UsersController < ApplicationController

  def index
    if current_user.admin?
      @users = User.where('users.id != ?', current_user.id)
    else
      @users = User.where('users.id != ?', current_user.id).accessible_by(current_ability)
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

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.save
  end

  def destroy
    @user = User.find(params[:id])
    authorize! :destroy, @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
