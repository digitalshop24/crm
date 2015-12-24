class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
 	  t.text :name
      t.text :feedback
      t.timestamps null: false
    end
  end
end
