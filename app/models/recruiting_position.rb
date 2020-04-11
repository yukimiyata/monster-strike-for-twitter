class RecruitingPosition < ApplicationRecord
  belongs_to :post

  has_one :joined_user, dependent: :destroy

  def to_save_recruit(recruiting_params, count)
    if count == 1
      [recruiting_params[0]]
    elsif count == 2
      [recruiting_params[1], recruiting_params[2]]
    elsif count == 3
      [recruiting_params[3], recruiting_params[4], recruiting_params[5]]
    end
  end

  def already_joined?(user_id)
    post.recruiting_positions.each do |recruit|
      return false if recruit.joined_user.present? && recruit.joined_user.user_id == user_id
    end

    true
  end
end
