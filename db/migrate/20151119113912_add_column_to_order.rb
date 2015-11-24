class AddColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :employee_price, :integer
  end
end
