class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role == 'Admin'
      can :manage, :all
    elsif user.role == 'Manager'
      can :manage, [Order, Part, Message, Payment, Event]
      can :read, [Client, Employee]
    elsif user.role == 'Client'
      can :create, [Order, Message]
      can :read, Part do |part|
        part.order.client_id == user.id && part.status == 'approved'
      end
      can :create, Payment
      can :upload_check, Payment, client_id: user.id
      can :read, Account, user_id: user.id
      can :read, Payment, client_id: user.id
      can [:read, :update], Order, client_id: user.id
      can :read, Message, receiver_id: user.id, status: :approved
      can :read, Message, sender_id: user.id
    elsif user.role == 'Employee'
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
    end

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
