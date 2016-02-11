class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user
  layout :layout_by_resource

  rescue_from CanCan::AccessDenied do |exception|
    if current_user && current_user.activated
      redirect_to_back(dashboard_index_path, exception.message)
    elsif current_user
      redirect_to dashboard_index_path
    else
      redirect_to_back(dashboard_index_path, exception.message)
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_index_path
  end

  def redirect_to_back(default = root_path, alert)
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
               :name, :phone, :city, :role, :skype, speciality_ids: [], subspeciality_ids: [])
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation, :current_password,
               :name, :phone, :city, :skype, speciality_ids: [], subspeciality_ids: [])
    end
  end

  def layout_by_resource
    if devise_controller?
      unless action_name == 'edit'
        "welcome"
      else
        "application"
      end
    else
      "application"
    end
  end

  def set_current_user
    User.current = current_user
    @worktypes = Worktype.all
  end

  def set_specialities
    @specialities = Speciality.all
    @subspecialities = Subspeciality.where(id: nil)
  end
end
