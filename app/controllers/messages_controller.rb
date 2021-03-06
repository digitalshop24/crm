require "smsc_api.rb"
class MessagesController < ApplicationController
  before_action :set_message, only: [:approve, :destroy, :resend]
  load_and_authorize_resource

  def create
    respond_to do |format|
      @message = Message.new(message_params)
      unless params[:price].to_s.empty?
        @message.content = "Стоимость: #{params[:price]} рублей <br>#{@message.content}"
      end
      @message.sender_id = current_user.id
      unless (['Admin', 'Manager'] & [current_user.role, User.find(@message.receiver_id).role]).empty?
        @message.approved!
      end
      if @message.save!
        if params[:send_email]
          mes1 = ERB::Util.url_encode("Здравствуйте, вам оставленно сообщение на сайте редстудент: ")
          s = "https://smsc.ru/sys/send.php?login=redstudent&psw=ERKol73Q&phones=#{@message.receiver.email}&mes="+ mes1 + @message.content + "&sender=Avtor@redstudent.ru&subj=Registration&mail=1&charset=utf-8"
          res = HTTParty.get(s)
          puts 'Отправлен email'
        end
        if params[:send_sms]
          sms = SMSC.new()
          ret = sms.send_sms( @message.receiver.phone, "Здравствуйте, вам оставленно сообщение на сайте редстудент")
          puts 'Отправлено sms'
        end
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
