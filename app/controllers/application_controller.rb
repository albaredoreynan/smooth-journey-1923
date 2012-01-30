class ApplicationController < ActionController::Base
  attr_accessor :current_branch, :current_company, :current_setting

  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :set_current_branch
  before_filter :set_current_company

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private
  def set_current_branch
    if user_signed_in?
      @current_branch = current_user.branches.first
    end
  end

  def set_current_company
    if user_signed_in?
      @current_company = current_user.companies.first
    end
  end

  def set_current_setting
    if user_signed_in?
      @current_setting = current_company.setting
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    send(:"new_#{scope}_session_path")
  end

  def render_csv(filename = nil)
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers['Content-Type'] = 'text/plain'
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Expires'] = "0"
    end
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""

    render :layout => false
  end
end
