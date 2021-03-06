class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user
  before_filter :init
  before_filter :add_allow_credentials_headers
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
  def add_allow_credentials_headers                                                                                                                                                                                                                                                        
    # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5                                                                                                                                                                                                      
    #                                                                                                                                                                                                                                                                                       
    # Because we want our front-end to send cookies to allow the API to be authenticated                                                                                                                                                                                                   
    # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so                                                                                                                                                                                                      
    # the browser will not reject the response                                                                                                                                                                                                                                             
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
    response.headers['Access-Control-Allow-Credentials'] = 'true'                                                                                                                                                                                                                          
  end 
  def options                                                                                                                                                                                                                                                                              
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'                                                                                                                                                                                                         
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
  def init
    @stock = Stock.last
    @news = News.last
    @question = Question.last
    @question1 = Question.first
    @feedback = Feedback.last
    @feedback1 = Feedback.first
    @worktypes = Worktype.all.order(:order)
    @contact=Seo.where(:code_title => 'Contacts').first
    @service=Seo.where(:code_title => 'Service').first
    @condition=Seo.where(:code_title => 'Conditions').first
    @pay=Seo.where(:code_title => 'Pay').first
    @advantage=Seo.where(:code_title => 'Advantages').first
    @g=Seo.where(:code_title => 'G').first
    @act= Seo.where(:code_title => 'Actions').first
    @ques = Seo.where(:code_title => 'Questions').first
    @feed = Seo.where(:code_title => 'Feedbacks').first
    @ne = Seo.where(:code_title => 'News').first
    @vacancy = Seo.where(:code_title => 'Vacancies').first
    @partner = Seo.where(:code_title => 'Partners').first
    @step = Seo.where(:code_title => 'Steps').first
    @offer = Seo.where(:code_title => 'Offers').first
  end
  def set_current_user
    User.current = current_user
  end

  def set_specialities
    @specialities = Speciality.all
    @subspecialities = Subspeciality.where(id: nil)
  end
end
