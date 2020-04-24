class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_token_secret, :string
  end
end
