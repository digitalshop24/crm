class Employee < User
  has_and_belongs_to_many :speciality, -> { uniq }
  has_and_belongs_to_many :subspeciality, -> { uniq }
  has_many :orders, class_name: "Order", foreign_key: "employee_id", dependent: :nullify
  after_create :add_account
  has_many :payouts
end
