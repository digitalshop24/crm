class Payout < ActiveRecord::Base
  # Вывод денег с личного счета исполнителя
  belongs_to :order
  belongs_to :employee
  enum status: %i[waiting denied finished]
end
