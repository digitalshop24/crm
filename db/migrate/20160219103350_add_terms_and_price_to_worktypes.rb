class AddTermsAndPriceToWorktypes < ActiveRecord::Migration
  def change
  	add_column :worktypes, :price, :text 
  	add_column :worktypes, :terms, :text 
  end
end
