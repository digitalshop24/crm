class Subspeciality < ActiveRecord::Base
  has_and_belongs_to_many :employees
  belongs_to :speciality
end
