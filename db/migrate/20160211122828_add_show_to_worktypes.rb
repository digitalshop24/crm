class AddShowToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :show, :boolean 
  end
end
