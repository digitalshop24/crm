class CreateSubspecialities < ActiveRecord::Migration
  def change
    create_table :subspecialities do |t|
      t.text :subspeciality
      t.references :speciality, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
