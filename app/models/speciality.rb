class Speciality < ActiveRecord::Base
  has_many :employees
  has_many :orders, dependent: :nullify
  has_many :subspecialities
  def to_s
    self.name
  end
end
