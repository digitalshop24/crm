class AddTextToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :description, :text 
  end
end
