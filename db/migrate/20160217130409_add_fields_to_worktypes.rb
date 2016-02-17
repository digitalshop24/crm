class AddFieldsToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :title, :string
  	add_column :worktypes, :mdescription, :string 
  end
end
