class AddDetailsToPayouts < ActiveRecord::Migration
  def change
  	add_column :payouts, :details, :string
  end
end
