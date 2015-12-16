class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :content
      t.string :link
      t.string :string
      t.string :event_type, default: false, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
