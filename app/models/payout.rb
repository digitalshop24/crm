class Payout < ActiveRecord::Base
  belongs_to :order
  belongs_to :employee
end
