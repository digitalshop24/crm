class Subspeciality < ActiveRecord::Base
  has_and_belongs_to_many :employees
  has_many :orders, dependent: :destroy
  belongs_to :speciality
end
