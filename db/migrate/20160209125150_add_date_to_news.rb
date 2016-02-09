class AddDateToNews < ActiveRecord::Migration
  def change
  	add_column :news, :date, :date
  	add_column :feedbacks, :date, :date
  	add_column :questions, :date, :date
  end
end
