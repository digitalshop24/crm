class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount, null: false, scale: 2, precision: 12
      t.string :currency, null: false, limit: 3, default: 'RUB'

      t.timestamps null: false
    end
  end
end
