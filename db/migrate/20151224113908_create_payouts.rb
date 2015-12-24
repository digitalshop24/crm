class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :employee_id, null: false, references: [:users, :id]
      t.decimal :amount, null: false, scale: 2, precision: 12
      t.string :currency, null: false, limit: 3, default: 'RUB'
      t.integer :status, null: false, default: 0
      t.datetime :sys_date

      t.timestamps null: false
    end
  end
end
