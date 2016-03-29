class AddNewDescToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :descr, :string
  end
end
