FactoryBot.define do
  factory :relationship do
    follower_id { follower_id }
    followed_id { followed_id }
  end
end
