class UsersController < ApplicationController

  set_tab :user

  def index
    @suppliers = Supplier.all
    @companies = Company.all
    @resto = Restaurant.all
    if current_user.admin?
      @users = User.where('users.id != ?', current_user.id).page(params[:page])
      @roles = Role.all
    else
      @users = User.where('users.id != ?', current_user.id).accessible_by(current_ability).page(params[:page])
      @roles = Role.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.company_id = @current_company.id
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
    authorize! :edit, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_path, :notice => 'User was successfully saved.' }
      else
        format.html { render :action => 'edit' }
      end
    end
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
