class DropCommentariesTable < ActiveRecord::Migration
  def change
    drop_table :commentaries
  end
end
