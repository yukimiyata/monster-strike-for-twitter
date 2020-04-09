class Blacklist < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :target_user, class_name: 'User'
  validates :user_id, presence: true
  validates :target_user_id, presence: true
end
