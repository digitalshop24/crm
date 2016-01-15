class Employee < User
  has_and_belongs_to_many :speciality
  has_and_belongs_to_many :subspeciality
  has_many :orders, class_name: "Order", foreign_key: "employee_id", dependent: :nullify
  after_create :add_account
  has_many :payouts
end
