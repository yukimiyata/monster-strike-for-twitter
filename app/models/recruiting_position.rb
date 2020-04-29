class RecruitingPosition < ApplicationRecord
  belongs_to :post
  has_one :joined_user, dependent: :destroy

  validates :character, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }
end
