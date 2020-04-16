class RecruitingPosition < ApplicationRecord
  belongs_to :post
  has_one :joined_user, dependent: :destroy
end
