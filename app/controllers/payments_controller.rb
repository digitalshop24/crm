class PaymentsController < ApplicationController
  before_action :set_payment, only: [:update, :destroy, :upload_check, :show, :approve, :deny]
  skip_before_action :verify_authenticity_token, :if => :allowed_ip?, only: [:confirm_invoice, :notify]
  load_and_authorize_resource :except => [:notify]

  def allowed_ip?
    true
  end

  def index
    @payments = Payment.preload(:order, client: [:account]).paginate(page: params[:page])
  end

  def show
  end

  def create
    payment = Payment.new(payment_params)
    if payment_params[:order_id]
      return redirect_to root_path, notice: 'Ошибка' unless payment.order.client_id == payment.client_id
    end
    payment.expires = Time.now + 10.days
    if payment.save
      if current_user.role == 'Client'
        return redirect_to payment
      end
      redirect_to :back, notice: 'Счет успешно создан'
    else
      redirect_to :back, alert: 'Ошибка'
    end
  end

  def upload_check
    if @payment.update(upload_params)
      @payment.update(status: :модерация)
      redirect_to :back, notice: 'Чек загружен'
    else
      redirect_to :back, alert: 'Ошибка'
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to :back, notice: 'Счет успешно обновлен'
    else
      redirect_to :back, alert: 'Ошибка'
    end
  end

  def destroy
    @payment.destroy
    redirect_to :back, notice: 'Счет усешно удален'
  end

  def approve
    if @payment.модерация?
      if @payment.подтвержден!
        unless @payment.order_id
          account = @payment.client.account
          if account.currency == @payment.currency
            account.update(amount: account.amount + @payment.amount)
          end
        end
        @payment.update(sys_date: Time.now)
        redirect_to :back, notice: 'Оплата подтверждена'
      else
        redirect_to :back, alert: 'Ошибка'
      end
    else
      redirect_to :back, alert: 'Оплата уже была подтверждена/отклонена ранее'
    end
  end

  def pay
    
    if (current_user.account.amount > @payment.amount)
      account = current_user.account
      account.update(amount: account.amount - @payment.amount)
      @payment.update(status: :подтвержден, sys_date: Time.now)
      redirect_to :back, notice: 'Оплачено'
    else
      redirect_to :back, alert: 'Недостаточно денег'
    end
  end


  def deny
    if @payment.модерация?
      if @payment.отклонен!
        redirect_to :back, notice: 'Оплата отклонена'
      else
        redirect_to :back, notice: 'Ошибка'
      end
    end
  end
 

  def confirm_invoice
    if params[:LMI_MERCHANT_ID] == Payment::LMI_MERCHANT_ID
      payments = Payment.ожидает.where(id: params[:LMI_PAYMENT_NO], amount: params[:LMI_PAYMENT_AMOUNT], currency: params[:LMI_CURRENCY])
      if payments.count == 1
        return render :nothing => true, :status => 200
      end
    end
    render plain: "NO"
  end

  def notify
    
    if params[:LMI_MERCHANT_ID] == Payment::LMI_MERCHANT_ID
      payment = Payment.ожидает.find_by(id: params[:LMI_PAYMENT_NO], amount: params[:LMI_PAYMENT_AMOUNT], currency: params[:LMI_CURRENCY])
      if payment
        payment.update(sys_id: params[:LMI_SYS_PAYMENT_ID], status: :подтвержден, sys_date: params[:LMI_SYS_PAYMENT_DATE])
      end
    end
    render nothing: true
  end

  private
  def set_payment
    @payment = Payment.find(params[:id])
  end

  def upload_params
    params.require(:payment).permit(:check)
  end

  def payment_params
    params.require(:payment).permit(:order_id, :client_id, :amount, :currency, :status)
  end
end
