class MessagesController < ApplicationController
  before_action :set_message, only: [:approve, :destroy, :resend]
  load_and_authorize_resource  

  def create
    message = Message.new(message_params)
    order = Order.find(message.order_id)
    message.sender_id = current_user.id
    message.receiver_id = params['receiver'].first.first
    # if [order.client_id, order.manager_id, order.employee_id].include? receiver_id
    #   message.receiver_id = params['receiver'].first.first
    # end
    if current_user.role == 'Employee'
      message.order_id = order.id if order.employee_id == current_user.id
    elsif current_user.role == 'Client'
      message.order_id = order.id if order.client_id == current_user.id
    end
    unless (['Admin', 'Manager'] & [current_user.role, User.find(message.receiver_id).role]).empty?
      message.approved!
    end
    if message.save
      redirect_to order_path(message.order_id), notice: 'Сообщение отправлено'
    else
      redirect_to order_path(message.order_id), notice: 'Ошибка'
    end
  end

  def approve
    if @message.approved!
      redirect_to order_path(@message.order_id), notice: 'Сообщение одобрено'
    else
      redirect_to order_path(@message.order_id), notice: 'Ошибка'
    end
  end

  def resend
    receiver_id = @message.sender.role == 'Client' ? @message.order.employee_id : @message.order.client_id
    @message.update(status: :approved, receiver_id: receiver_id)
    redirect_to order_path(@message.order_id)
  end

  def destroy
    if @message.destroy
      redirect_to order_path(@message.order_id), notice: 'Сообщение успешно удалено'
    else
      redirect_to order_path(@message.order_id), notice: 'Ошибка'
    end
  end

  private
  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content, :receiver_id, :order_id)
  end
end
