class SettingsController < ApplicationController
  load_and_authorize_resource :company
  
  set_tab :settings
  
  def index
    @company = @current_company
  end

  def update
    @company = @current_company

    if @company.update_attributes(params[:company])
      redirect_to settings_path, :notice => 'Settings has been updated.'
    else
      redirect_to settings_path, :notice => 'Unable to update settings. Please try again.'
    end
  end
end
