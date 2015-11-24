class Payment < ActiveRecord::Base
  LMI_MERCHANT_ID = '12345'
  belongs_to :order
  belongs_to :client
  enum status: %i[waiting approved expired]

  def paymaster_link
    '#'
  end
end
