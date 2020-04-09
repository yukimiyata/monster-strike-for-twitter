class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, presence: true

  has_many :posts
  has_many :joined_user
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_blacklists, class_name: 'Blacklist', foreign_key: 'user_id', dependent: :destroy
  has_many :blacklisting, through: :active_blacklists, source: :target_user
  has_many :passive_blacklists, class_name: 'Blacklist', foreign_key: 'target_user_id', dependent: :destroy
  has_many :blacklisted, through: :passive_blacklists, source: :user
end
