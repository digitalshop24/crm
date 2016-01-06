class Manager < User
  has_many :orders, class_name: "Order", foreign_key: "manager_id", dependent: :nullify
end
