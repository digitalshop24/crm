class AddOrderToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :order, :integer
  end
end
