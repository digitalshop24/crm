class PayoutsController < ApplicationController
  before_action :set_payout, only: [:update, :destroy, :upload_check, :show, :approve, :deny]
  load_and_authorize_resource

  def index
    @payouts = Payout.all.paginate(page: params[:page])
  end
  
  def deny
     if @payout.waiting?
      if @payout.denied!
        redirect_to :back, notice: 'Выплата отклонена'
      else
        redirect_to :back, notice: 'Ошибка'
      end
    end
  end

  def approve
    if @payout.waiting?
      emp = Employee.find(@payout.employee_id)  
      res = emp.account.amount - @payout.amount if emp.account.amount >= @payout.amount
      if @payout.finished! && res >= 0
         emp = Employee.find(@payout.employee_id)  
         emp.account.update_attribute(:amount, res)
         redirect_to :back, notice: 'Выплата подтверждена'
      else
        redirect_to :back, alert: 'Ошибка'
      end
    else
      redirect_to :back, alert: 'Выплата уже была подтверждена/отклонена ранее'
    end
  end
  
  def pay
    payout = Payout.new(payout_params)
    if payout_params[:order_id]
      return redirect_to root_path, notice: 'Ошибка' unless payout.order.employee_id == payout.employee_id
      account = payout.employee.account
      account.update(amount: account.amount + payout.amount)
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
    if (current_user.account.amount > payout.amount)
      payout.employee_id = current_user.id
      if payout.save
        redirect_to :back, notice: 'Заявка на выплату создана'
      else
        redirect_to :back, alert: 'Ошибка'
      end
    else
      redirect_to :back, alert: 'Недостаточно денег'
    end
  end

  private
  def set_payout
    @payout = Payout.find(params[:id])
  end
  def create_params
    params.require(:payout).permit(:amount, :details)
  end
  def payout_params
    params.require(:payout).permit(:order_id, :employee_id, :amount, :status, :details)
  end
end
