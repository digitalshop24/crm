class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    puts '1'*100
    puts @order.status
    if @order.status == 'moderation'
      render 'orders/show'
    else
      render "dashboard/order"
    end
  end

  def approve
    @order.update(status: :approved)
      redirect_to @order, notice: 'Заказ одобрен'
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.client_id = current_user.id if current_user.role == "Client"

    if @order.save
      redirect_to @order, notice: 'Speciality was successfully created.'
    else
      render :new
    end
  end


  # POST /orders


  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to dashboard_index_path, notice: 'Заказ успешно удален'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    permitted = params.require(:order).permit(:worktype_id, :worktype_other, :speciality_id, :speciality_other,
                                              :institution, :theme, :uniqueness, :document, :comment, :deadline,
                                              :page_number)
    if ["Admin", "Manager"].include?(current_user.role)
      permitted.merge(params.require(:order).permit(:client_id, :employee_id, :employee_deadline, :inform_date, :status, :price))
    end
  end

  # Only allow a trusted parameter "white list" through.


end
