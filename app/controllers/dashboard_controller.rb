class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
    @events = Event.where(:status => nil)
    case current_user.role
    when 'Admin'
      redirect_to users_path
    when 'Client'
      @orders = current_user.orders.paginate(:page => params[:page])
      render 'dashboard/client/orders'
    when 'Manager'
      @orders = Order.paginate(page: params[:page], per_page: 15)
      render 'orders/index'
    when 'Employee'
      @orders = current_user.orders.paginate(:page => params[:page])
      render 'dashboard/employee/my_orders'
    end
  end

  def new_orders
     @orders = Order.employee_searching.where(speciality_id: current_user.speciality_id).paginate(:page => params[:page])
     render 'dashboard/employee/new_orders'
  end

  def create_order
    @order = Order.new
    render "dashboard/#{current_user.role.downcase}/create_order"
  end
end
