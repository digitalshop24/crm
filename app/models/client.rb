class Client < User
  has_many :orders, class_name: "Order", foreign_key: "client_id", dependent: :nullify
  has_many :payments
  after_create :add_account
end
