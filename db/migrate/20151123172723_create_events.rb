class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :content
      t.string :link
      t.string :string
      t.integer :user_id,default: false, null: false
      t.string :event_type, default: false, null: false

      t.timestamps null: false
    end
  end
end
