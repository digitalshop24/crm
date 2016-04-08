class AddReqToPayments < ActiveRecord::Migration
  def change
  	add_column :payments, :details, :string
  end
end
