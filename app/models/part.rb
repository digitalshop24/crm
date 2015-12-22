class Part < ActiveRecord::Base
  belongs_to :order
  has_attached_file :file
  validates_attachment_file_name :file, :matches => [/docx?\Z/, /pdf\Z/, /xlsx?\Z/]
  enum status: %i[waiting moderation approved rework denied]

  def self.status_names_for_select
    names = []
    statuses.keys.each do |status|
      display_name = I18n.t("activerecord.attributes.#{self.name.downcase}.statuses.#{status}", default: status.titleize)
      names << [display_name, status]
    end
    names
  end

  after_save :add_event
  def add_event
      event_params = { :user_id => User.current.id, :content => self.description, :event_type => "часть", :link => "orders/#{self.order.id}" }
      event = Event.new(event_params)
      event.save
  end
end
