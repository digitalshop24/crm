require "smsc_api.rb"
class Devise::PasswordsController < DeviseController
   layout 'welcome'
  prepend_before_action :require_no_authentication
  # Render the #edit only if coming from a reset password email link
  append_before_action :assert_reset_token_passed, only: :edit

  # GET /resource/password/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/password
  def create
    @raw_token, hashed_token = Devise.token_generator.generate(User, :reset_password_token)
    user = User.where(email: resource_params[:email]).first
    user.reset_password_token = hashed_token
    user.reset_password_sent_at = Time.now
    user.save
    mes1 = ERB::Util.url_encode("Здравствуйте, чтобы восстановить пароль перейдите по ссылке: ")
    binding.pry
    s = "https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{resource_params[:email]}&mes="+ mes1  + "http://redstudent.ru/users/password/edit?reset_password_token=#{@raw_token}&sender=Avtor@redstudent.ru&subj=Registration&mail=1&charset=utf-8"
    res = HTTParty.get(s)
    p "/users/password/edit?initial=true&reset_password_token=#{@raw_token}"
    redirect_to :root
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.new
    set_minimum_password_length
    resource.reset_password_token = params[:reset_password_token]
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        #flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        #set_flash_message!(:notice, flash_message)
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      respond_with resource
    end
  end

  protected
    def after_resetting_password_path_for(resource)
      Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
    end

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      new_session_path(resource_name) if is_navigational_format?
    end

    # Check if a reset_password_token is provided in the request
    def assert_reset_token_passed
      if params[:reset_password_token].blank?
        set_flash_message(:alert, :no_token)
        redirect_to new_session_path(resource_name)
      end
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end

    def translation_scope
      'devise.passwords'
    end
end