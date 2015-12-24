class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
	  t.text :question
      t.text :answer
      t.timestamps null: false
    end
  end
end
