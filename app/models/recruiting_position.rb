class RecruitingPosition < ApplicationRecord
  belongs_to :post

  has_one :joined_user, dependent: :destroy

  def already_joined?(user_id)
    post.recruiting_positions.each do |recruit|
      return false if recruit.joined_user.present? && recruit.joined_user.user_id == user_id
    end

    true
  end
end
