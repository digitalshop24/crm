class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :client_id, null: false, references: [:users, :id]
      t.decimal :amount, null: false, scale: 2, precision: 12
      t.string :currency, null: false, limit: 3, default: 'RUB'
      t.datetime :expires, null: false
      t.integer :status, null: false, default: 0
      t.attachment :check
      t.string :sys_id
      t.datetime :sys_date

      t.timestamps null: false
    end
  end
end
