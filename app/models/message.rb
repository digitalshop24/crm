class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :order
  enum status: %i[moderation approved denied]

  def sender_role

  end
  after_create :add_event
  def add_event
    event_params = { :user_id => self.sender.id, :event_type => "сообщение", :content  => self.content, :link => "orders/#{self.order_id}##{self.id}" }
    event = Event.new(event_params)
    event.save
  end
end
