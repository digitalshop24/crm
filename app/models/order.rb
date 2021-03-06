class Order < ActiveRecord::Base
  belongs_to :worktype
  belongs_to :speciality
  belongs_to :subspeciality
  belongs_to :client, class_name: "Client"
  belongs_to :employee, class_name: "Employee"
  belongs_to :manager, class_name: "Manager"
  has_many :parts
  has_many :messages
  has_many :payments
  has_many :payouts
  has_many :revisions, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_attached_file :document
  validates_attachment_file_name :document, :matches => [/docx?\Z/, /pdf\Z/, /xlsx?\Z/]

  after_save :add_event

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

  def self.statuses_names_for_filter_select
    names = []
    statuses_sel = statuses.keys - ['finished']
    statuses_sel.each do |status|
      display_name = I18n.t("activerecord.attributes.#{self.name.downcase}.statuses.#{status}", default: status.titleize)
      names << [statuses[status], display_name]
    end
    names
  end

  def received_cash
    self.payments.подтвержден.sum(:amount)
  end
  def waiting_cash
    self.payments.ожидает.sum(:amount)
  end
  def waiting_cash?
    waiting_cash > 0
  end
  def payed_cash
    self.payouts.sum(:amount)
  end
  def set_employee_deadline
    deadline = self[:deadline]
    if self[:deadline]
      self[:employee_deadline] = Time.now + (Time.new(deadline.year, deadline.month, deadline.day) - Time.now)/2
    end
  end
  def add_event
    if User.current.role!="Manager"
      event_params = { :user_id => (User.current.id if User.current), :event_type => "заказ", 
          :content  => "создал или изменил заказ", :link => "orders/#{self.id}" }
      event = Event.create(event_params)
    end
    if User.current
      if User.current.role!="Manager"
        if note_changed?
          event_params = { :user_id => User.current.id, :event_type => "заметку",
                           :content  => self.note, :link => "orders/#{self.id}" }
          event = Event.create(event_params)
        end
        if commentary_changed?
          event_params = { :user_id => User.current.id, :event_type => "заметку для автора",
                           :content  => self.commentary, :link => "orders/#{self.id}" }
          event = Event.create(event_params)
        end
      end
    end
  end

  def self.search(search)
    unless search.empty_values?
      statements = []
      query = [""]
      unless search[:theme].empty?
        statements << "lower(theme) LIKE lower(?)"
        query << "%#{search[:theme]}%"
      end
      unless search[:worktype_id].empty?
        statements << "worktype_id = ?"
        query << "#{search[:worktype_id]}"
      end
      unless search[:id].empty?
        statements << "id = ?"
        query << search[:id].to_i
      end
      unless search[:status].empty?
        statements << "status = ?"
        query << search[:status].to_i
      end
      unless search[:created_at].empty?
        created_at = Date.parse(search[:created_at])
        statements << "created_at BETWEEN '#{created_at.beginning_of_day}' and '#{created_at.end_of_day}'"
      end
      unless search[:inform_date].empty?
        inform_date = Date.parse(search[:inform_date])
        statements << "inform_date BETWEEN '#{inform_date.beginning_of_day}' and '#{inform_date.end_of_day}'"
      end
      query[0] = statements.join ' AND '
      where(query)
    else
      all
    end
  end
end
