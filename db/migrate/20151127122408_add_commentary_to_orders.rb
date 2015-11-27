class AddCommentaryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :commentary, :string
  end
end
