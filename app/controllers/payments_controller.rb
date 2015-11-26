class PaymentsController < ApplicationController
  before_action :set_payment, only: [:update, :destroy, :upload, :show]
  skip_before_action :verify_authenticity_token, :if => :allowed_ip?, only: [:confirm_invoice, :notify]
  load_and_authorize_resource

  def allowed_ip?
    request.remote_ip == '127.0.0.1'
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
      redirect_to :back, notice: 'Ошибка'
    end
  end

  def upload
    if @payment.update(upload_params)
      redirect_to :back, notice: 'Чек загружен'
    else
      redirect_to :back, notice: 'Ошибка'
    end
  end

  def update
    if @payment.update(payment_params)
      redirect_to :back, notice: 'Счет успешно обновлен'
    else
      redirect_to :back, notice: 'Ошибка'
    end
  end

  def destroy
    @payment.destroy
    redirect_to :back, notice: 'Счет усешно удален'
  end

  def confirm_invoice
    if params[:LMI_MERCHANT_ID] == Payment::LMI_MERCHANT_ID
      payments = Payment.waiting.where(id: params[:LMI_PAYMENT_NO], amount: params[:LMI_PAYMENT_AMOUNT], currency: params[:LMI_CURRENCY])
      if payments.count == 1
        return render plain: "YES"
      end
    end
    render plain: "NO"
  end

  def notify
    if params[:LMI_MERCHANT_ID] == Payment::LMI_MERCHANT_ID
      payment = Payment.waiting.find_by(id: params[:LMI_PAYMENT_NO], amount: params[:LMI_PAYMENT_AMOUNT], currency: params[:LMI_CURRENCY])
      if payment
        payments.first.update(sys_id: params[:LMI_SYS_PAYMENT_ID], status: :approved, sys_date: params[:LMI_SYS_PAYMENT_DATE])
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
