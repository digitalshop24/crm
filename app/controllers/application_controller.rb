class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to_back(dashboard_index_path, exception.message)
  end

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

  def redirect_to_back(default = root_url, alert)    
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back, alert: alert
    else
      redirect_to default, alert: alert
    end
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    edit_user_registration_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation,
               :name, :phone, :city, :speciality_id, :role, :skype)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password,
               :name, :phone, :city, :speciality_id, :skype)
    end
  end

  def set_current_user
    User.current = current_user
  end
end
