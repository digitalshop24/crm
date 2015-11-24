class AccountsController < ApplicationController
  def show
    @account = current_user.account
    render "dashboard/#{current_user.role.downcase}/account"
  end
end
