class CreateSeos < ActiveRecord::Migration
  def change
    create_table :seos do |t|
      t.string :name
      t.string :description
      t.string :title
      t.timestamps null: false
  end
  end
  def change
    add_column :seos, :code_title, :string
  end
end
