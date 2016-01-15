class CreateHabtmEmployeeTables < ActiveRecord::Migration
  def change
    remove_column :users, :speciality_id
    create_table :specialities_users, id: false do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :speciality, index: true
    end
    create_table :subspecialities_users, id: false do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :subspeciality, index: true
    end
    add_index :specialities_users, ["employee_id", "speciality_id"], unique: true
    add_index :subspecialities_users, ["employee_id", "subspeciality_id"], unique: true
  end
end
