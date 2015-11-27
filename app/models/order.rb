class Order < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :speciality
  belongs_to :client, class_name: "Client"
  belongs_to :employee, class_name: "Employee"
  belongs_to :manager, class_name: "Manager"
  has_many :parts
  has_many :messages
  has_many :payments
  require 'pry'

  has_attached_file :document
  validates_attachment_file_name :document, :matches => [/docx?\Z/, /pdf\Z/, /xlsx?\Z/]

  enum status: %i[moderation approved employee_searching prepayment_waiting in_work solved finished]

  def display_status
    I18n.t("activerecord.attributes.#{self.class.name.downcase}.statuses.#{status}", default: status.titleize)
  end

  def self.status_names_for_select
    names = []
    statuses.keys.each do |status|
      display_name = I18n.t("activerecord.attributes.#{self.name.downcase}.statuses.#{status}", default: status.titleize)
      names << [display_name, status]
    end
    names
  end
  def received_cash
    self.payments.approved.sum(:amount)
  end
  def waiting_cash
    self.payments.waiting.sum(:amount)
  end
  def set_employee_deadline
    deadline = self[:deadline]
    if self[:deadline]
      self[:employee_deadline] = Time.now + (Time.new(deadline.year, deadline.month, deadline.day) - Time.now)/2
    end
  end
  after_update :add_event
  def add_event
    if note_changed?
      event_params = { :user_id => self.manager_id, :event_type => "заметка", :content  => self.note, :link => "orders/#{self.id}" }
      event = Event.new(event_params)
      event.save
    end
    if commentary_changed?
      event_params = { :user_id => self.manager_id, :event_type => "заметка для автора", :content  => self.commentary, :link => "orders/#{self.id}" }
      event = Event.new(event_params)
      event.save
    end
  end
end
