class AddSubspecialityToOrders < ActiveRecord::Migration
 def change
 	add_reference :orders, :subspeciality, index: true
  end
end
