class CreateTforms < ActiveRecord::Migration
  def change
    create_table :tforms do |t|
      t.string :name
      t.string :city
      t.string :email
      t.timestamps null: false
    end
  end
end
