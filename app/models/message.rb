class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :order
  enum status: %i[moderation approved denied]
  after_create :add_event

  def add_event
    event_params = { user_id: self.sender.id, event_type: "сообщение", content: self.content, link: "orders/#{self.order_id}##{self.id}" }
    @event = Event.create(event_params)
    channel = '/faye/events'
    msg = ApplicationController.new.render_to_string @event
    client = Faye::Client.new("http://#{ENV['host']}/faye")
    client.publish(channel, {message: msg })
  end
end
