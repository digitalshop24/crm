class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :name
      t.string :description
      t.string :title
      t.string :code_title
      t.timestamps null: false
  end
end
end
