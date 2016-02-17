class CreateSeos < ActiveRecord::Migration
  def change
    add_column :seos, :code_title, :string
  end
end
