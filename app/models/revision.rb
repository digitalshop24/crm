class Revision < ActiveRecord::Base
  has_attached_file :document, default_url: false
  do_not_validate_attachment_file_type :document
  validates :comment, presence: true
  validates :order_id, presence: true
  belongs_to :order

  enum status: %i[moderation approved denied]
  after_save :add_event
  def add_event
    if User.current.role!="Manager"
      event_params = { :user_id => User.current.id, :content => self.comment, :event_type => "доработку", :link => "orders/#{self.order.id}" }
      event = Event.new(event_params)
      event.save
    end
  end
end
