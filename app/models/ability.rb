class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role == 'Admin'
      can :manage, :all
    elsif user.role == 'Manager'
      can :pay, Payout
      can :manage, [Order, Part, Message, Event, Revision, Material]
      can :create, Payment
      can :read, [Client, Employee]
    elsif user.role == 'Client'
      can :create, [Order, Message, Revision, Material]
      can :read, Part do |part|
        part.order.client_id == user.id && part.status == 'approved'
      end
      can :create, Payment
      can [:show, :upload_check, :pay], Payment, client_id: user.id
      can :read, Material, order: { client_id: user.id }
      can :read, Revision, order: { client_id: user.id }
      can :read, Account, user_id: user.id
      can [:read, :update], Order, client_id: user.id
      can :read, Message, receiver_id: user.id, status: :approved
      can :read, Message, sender_id: user.id
    elsif user.role == 'Employee'
      can :create, Payout 
      can :read, Material, order: {employee_id: user.id}, status: 'approved'
      can :read, Revision, order: {employee_id: user.id}, status: 'approved'
      can :read, Order, employee_id: user.id
      can :read, Order, employee_id: nil
      can :upload, Part do |part|
        part.status.in?( ['waiting', 'rework'] ) && part.order.employee_id == user.id
      end
      can :read, Order do |order|
        order.status == 'employee_searching'
      end
      can :create, Message
      can :read, Message, receiver_id: user.id, status: :approved
      can :read, Message, sender_id: user.id
    else 
      can :confirm_invoice, Payment
      can :read, [News, Question, Feedback]
    end
  end
end
