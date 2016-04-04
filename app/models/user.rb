require "smsc_api.rb"
class User < ActiveRecord::Base
  ROLES = ['admin', 'manager', 'employee', 'client']
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  self.inheritance_column = 'role'
  has_many :sended_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :received_messages, foreign_key: "receiver_id", class_name: "Message"
  has_one :account, dependent: :destroy
  has_many :events, dependent: :destroy
  after_create :add_event

  def self.search(search)
    if search
      where(["lower(name) LIKE lower(?) and lower(email) LIKE lower(?)", "%#{search[:name]}%", "%#{search[:email]}%"])
    else
      all
    end
  end

  def self.roles_for_select
    ROLES.map{ |r| [r.capitalize, I18n.t("activerecord.attributes.user.roles.#{r}")] }
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    #UserMailer.password_reset(self).deliver
  end

  def glyphicon
    glyphicons = { 'Admin' => 'glyphicon-user',
                   'Manager'=> 'glyphicon-user',
                   'Employee' => 'glyphicon-education',
                   'Client' => 'glyphicon-piggy-bank'
                   }
    glyphicons[self.role]
  end
  def text_style
    text_styles = { 'Admin' => 'text-primary',
                    'Manager'=> 'text-primary',
                    'Employee' => 'text-warning',
                    'Client' => 'text-success'
                    }
    text_styles[self.role]
  end

  def name_for_select
    "#{self.name} (#{self.email})"
  end
  def add_account
    Account.create(user_id: self.id, amount: 0, currency: 'RUB')
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
  def add_event
        @client = self
        token = @client.send(:set_reset_password_token)
        mes1 = ERB::Util.url_encode("Здравствуйте, вы успешно зарегистрировались в системе ")
        mes2 = ERB::Util.url_encode(" Перейти в личный кабинет: ")
        s = "https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes="+ mes1 + "http://redstudent.ru/." + mes2 + "http://redstudent.ru/users/password/edit?reset_password_token=#{token}&sender=Avtor@redstudent.ru&subj=Registration&mail=1&charset=utf-8"
        res = HTTParty.get(s)
        sms = SMSC.new()
        ret = sms.send_sms( @client.phone, "Вы успешно зарегистрированы на сайте редстудент, вам на электронную почту придут дальнейшие инструкции")
        #message = "#{ENV['host']}/users/password/edit?reset_password_token=#{token}"
        #email = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes=#{message}&sender=Avtor@redstudent.ru&subj=Registration&mail=1")
        #sms = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.phone}&mes=Ваш Редстудент")
        #email = URI.encode("https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@client.email}&mes=test&sender=3206297@mail.ru&subj=test&mail=1")
        #uri = URI(email)
        #url = URI(sms)
        #a = Net::HTTP.get(uri)
        event_params = { :user_id => self.id, :event_type => self.role, :content  => self.email, :link => "admin/users/#{self.id}/edit/", :string => 'usr'}
        event = Event.create(event_params)
  end
end
