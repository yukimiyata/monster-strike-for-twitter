class AddIndexToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :joined_users, :recruiting_position_id
    add_index :joined_users, :recruiting_position_id, unique: true
  end
end
