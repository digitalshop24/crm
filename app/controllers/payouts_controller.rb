class PayoutsController < ApplicationController
  before_action :set_payout, only: [:update, :destroy, :upload_check, :show, :approve, :deny]
  load_and_authorize_resource

  def pay
    payout = Payout.new(payout_params)
    if payout_params[:order_id]
      return redirect_to root_path, notice: 'Ошибка' unless payout.order.employee_id == payout.employee_id
      account = payout.emploee.account
      account.update(amount: account.amount + payment.amount)
      payout.status = :finished
    else
      redirect_to :back, alert: 'Ошибка'
    end
    if payout.save
      redirect_to :back, notice: 'Выплата проведена'
    else
      redirect_to :back, alert: 'Ошибка'
    end
  end

  def create
    payout = Payout.new(create_params)
    payout.employee_id = current_user.id
    if payout.save
      redirect_to :back, notice: 'Заявка на выплату создана'
    else
      redirect_to :back, alert: 'Ошибка'
    end
  end

  private
  def set_payout
    @payout = Payout.find(params[:id])
  end
  def create_params
    params.require(:payout).permit(:amount)
  end
  def payout_params
    params.require(:payout).permit(:order_id, :employee_id, :amount, :status)
  end
end
