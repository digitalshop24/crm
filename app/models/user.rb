class User < ActiveRecord::Base
  ROLES = ['admin', 'manager', 'employee', 'client']
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  self.inheritance_column = 'role'
  has_many :sended_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :received_messages, foreign_key: "receiver_id", class_name: "Message"
  has_one :account
  has_many :events

  def self.search(search)
    if search
      where(["name LIKE ? and email LIKE ?", "%#{search[:name]}%", "%#{search[:email]}%"])
    else
      all
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
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
end
