class CreateRecruitingPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |r|
      r.string :character
      r.text :description
      r.references :post, foreign_key: true, null: false
      r.timestamps
    end
  end
end
