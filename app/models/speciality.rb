class Speciality < ActiveRecord::Base
  has_and_belongs_to_many :employees
  has_many :subspecialities
  has_many :orders, dependent: :nullify
  def to_s
    self.name
  end
end
