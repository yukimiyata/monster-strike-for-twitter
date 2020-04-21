class JoinedUser < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :recruiting_position

  validates :recruiting_position_id, uniqueness: true

  def join_quest(recruiting_id, post_id)
    self.recruiting_position_id = recruiting_id
    self.post_id = post_id
  end
end
