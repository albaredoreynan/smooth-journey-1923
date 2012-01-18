class SettingsController < ApplicationController
  load_and_authorize_resource

  before_filter :load_setting

  def index
    authorize! :show, @setting
  end

  def update
    if @setting.update_attributes(params[:setting])
      redirect_to settings_path
    else
      redirect_to settings_path, :notice => 'Unable to update settings. Please try again.'
    end
  end

  private
  def load_setting
    @setting = current_user.setting
  end
end

