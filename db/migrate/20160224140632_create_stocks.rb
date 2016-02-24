class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :title
      t.text :text
      t.date :date
	  t.attachment :image
      t.timestamps null: false
    end
  end
end
