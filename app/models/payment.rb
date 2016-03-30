class Payment < ActiveRecord::Base
  # Платежи от клиентов
  LMI_MERCHANT_ID = 'd2445484-8d40-4603-b43f-76d49c5a755a'
  belongs_to :order
  belongs_to :client
  enum status: %i[ожидает модерация подтвержден отклонен истек]
  has_attached_file :check
  do_not_validate_attachment_file_type :check

  def paymaster_link
    '#'
  end
end