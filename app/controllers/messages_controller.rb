class MessagesController < ApplicationController
  before_action :set_message, only: [:approve, :destroy, :resend]
  load_and_authorize_resource

  def create
    respond_to do |format|
      @message = Message.new(message_params)
      unless params[:price].empty?
        @message.content = "Стоимость: #{params[:price]} рублей <br>#{@message.content}"
      end
      @message.sender_id = current_user.id
      @message.receiver_id = params['receiver'].first.first
      unless (['Admin', 'Manager'] & [current_user.role, User.find(@message.receiver_id).role]).empty?
        @message.approved!
      end
      if @message.save
        flash.now[:success] = 'Сообщение отправлено'
      else
        flash.now[:error] = 'Ошибка'
      end
      format.html {redirect_to order_path(@message.order_id)}
      format.js
    end
  end

  def approve
    respond_to do |format|
      if @message.approved!
        flash.now[:success] = 'Сообщение одобрено'
      else
        flash.now[:error] = 'Ошибка'
      end
      format.html {redirect_to order_path(@message.order_id)}
      format.js
    end
  end

  def resend
    respond_to do |format|
      receiver_id = @message.sender.role == 'Client' ? @message.order.employee_id : @message.order.client_id
      if @message.update(status: :approved, receiver_id: receiver_id)
        flash.now[:success] = 'Сообщение переслано'
      else
        flash.now[:error] = 'Ошибка'
      end
      format.html {redirect_to order_path(@message.order_id)}
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @message.destroy
        flash.now[:success] = 'Сообщение удалено'
      else
        flash.now[:success] = 'Ошибка'
      end
      format.html {redirect_to order_path(@message.order_id)}
      format.js
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
