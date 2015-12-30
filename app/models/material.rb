class Material < ActiveRecord::Base
  has_attached_file :document, default_url: false
  do_not_validate_attachment_file_type :document
  validates :order_id, presence: true
  belongs_to :order

  enum status: %i[moderation approved denied]

  after_save :add_event
  def add_event
    if User.current.role!="Manager"
      if User.current
        event_params = { :user_id => User.current.id, :content => self.document_file_name, :event_type => "файл", :link => "orders/#{self.order.id}" }
      else
        event_params = { :content => self.document_file_name, :event_type => "файл", :link => "orders/#{self.order.id}" }
      end  
        event = Event.new(event_params)
        event.save
    end
  end
  
end
