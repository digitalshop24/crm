class Payout < ActiveRecord::Base
  belongs_to :order
  belongs_to :employee
  enum status: %i[waiting denied finished]
end
