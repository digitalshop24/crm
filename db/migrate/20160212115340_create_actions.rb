class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :title
      t.text :text
      t.attachment :image
      t.date :date
      t.timestamps null: false
    end
  end
end

