$faye = Faye::Client.new("http://#{ENV['host']}/faye")
class FayeWrapper
  def self.publish(channel, msg)
    run_event_machine
    $faye.publish(channel, msg)
  end

  def self.run_event_machine
    Thread.new { EM.run } unless EM.reactor_running?
    Thread.pass until EM.reactor_running?
  end
end

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :order
  enum status: %i[moderation approved denied]
  #after_create :add_event

  def add_event
    if User.current.role!="Manager"
      event_params = { user_id: self.sender.id, event_type: "сообщение", content: self.content.strip_tags, link: "orders/#{self.order_id}##{self.id}" }
      @event = Event.create(event_params)
      channel = '/faye/events'
      msg = ApplicationController.new.render_to_string @event
      FayeWrapper.publish(channel, { message: msg })
    end
  end
end

