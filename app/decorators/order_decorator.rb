class OrderDecorator < ApplicationDecorator
  delegate_all
  def row_style
    if order.moderation?
      style = 'class=new-item'
    elsif order.waiting_cash?
      style = 'class=warning-item'
    end
  end
end
