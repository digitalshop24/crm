class WelcomeController < ApplicationController
  # load_and_authorize_resource :class => false
  layout 'welcome'
  def index
    @order = Order.new
    @client = Client.new
  end

  def create_order
    @order = Order.new(order_params.except(:client))
    if current_user
      @order.client_id = current_user.id if current_user.role = "Client"
    else
      @client = Client.new(order_params[:client])
      @client.password = SecureRandom.hex
      if @client.save
        @order.client_id = @client.id
        token = @client.send(:set_reset_password_token)
        Devise::Mailer.reset_password_instructions(@client, token).deliver_now
        if @order.save
          redirect_to root_path, notice: 'Заказ успешно создан. Вы получите на email инструкцию для входа в личный кабинет'
        else
          redirect_to root_path
        end
      else
        flash[:notice] = 'Такой email уже зарегистрирован в системе'
        redirect_to root_path
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:worktype_id, :worktype_other, :speciality_id, :speciality_other,
                                  :institution, :theme, :uniqueness, :document, :comment, :deadline,
                                  :page_number, { client: [:email, :phone] })
  end
end
