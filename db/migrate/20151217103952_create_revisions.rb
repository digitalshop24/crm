class CreateRevisions < ActiveRecord::Migration
  def change
      create_table :revisions do |t|
      t.text :comment
      t.attachment :document
      t.references :order, index: true, foreign_key: true
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
