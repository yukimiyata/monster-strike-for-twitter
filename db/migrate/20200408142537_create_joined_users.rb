class CreateJoinedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :joined_users do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.references :recruiting_position, foreign_key: true

      t.timestamps
    end
  end
end
