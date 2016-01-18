class OrderDecorator < ApplicationDecorator
  delegate_all
  def row_style
    if order.moderation?
      'class=new-item'
    elsif order.waiting_cash?
      'class=warning-item'
    end
  end
end
