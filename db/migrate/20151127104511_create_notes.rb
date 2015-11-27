class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|

      t.integer :manager_id, null: false, foreign_key: true
      t.text :content
      t.references :order, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end