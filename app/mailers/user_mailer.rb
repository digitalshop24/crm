class UserMailer < Devise::Mailer
  def set_password_instructions(record, token)
    @token = token
    resource = initialize_from_record(record)
    headers = { subject: 'Регистрация на сайте RedStudent',
                to: resource.email,
                from: "RedStudent <#{ENV['mailer_user_name']}>"
                }
    mail headers
  end
end
