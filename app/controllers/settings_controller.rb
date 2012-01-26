class SettingsController < ApplicationController
  load_and_authorize_resource :company

  def index
    @company = @current_company
  end

  def update
    @company = @current_company

    if @company.update_attributes(params[:company])
      redirect_to settings_path
    else
      redirect_to settings_path, :notice => 'Unable to update settings. Please try again.'
    end
  end
end
