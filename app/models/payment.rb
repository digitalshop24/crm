class Payment < ActiveRecord::Base
  LMI_MERCHANT_ID = '12345'
  belongs_to :order
  belongs_to :client
  enum status: %i[waiting moderation approved denied expired]
  has_attached_file :check
  do_not_validate_attachment_file_type :check

  def paymaster_link
    '#'
  end
end
