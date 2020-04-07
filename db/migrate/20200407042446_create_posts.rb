class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |p|
      p.string :quest_name, null:false
      p.string :invite_url, null:false
      p.integer :member_capacity, null:false, default: 3
      p.references :user, foreign_key: true, null: false
      p.timestamps
    end
  end
end
