class User < ApplicationRecord
  authenticates_with_sorcery!
  include Encryptor

  has_many :posts, dependent: :destroy
  has_many :joined_user, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_blacklists, class_name: 'Blacklist', foreign_key: 'user_id', dependent: :destroy
  has_many :blacklisting, through: :active_blacklists, source: :target_user
  has_many :passive_blacklists, class_name: 'Blacklist', foreign_key: 'target_user_id', dependent: :destroy
  has_many :blacklisted, through: :passive_blacklists, source: :user

  validates :name, presence: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true, allow_blank: true
  validates :game_name, length: { maximum: 12 }

  enum role: { general: 0, admin: 1 }

  def latest_post
    posts.last
  end

  def following_or_blacklisting?(target_user)
    blacklisting.include?(target_user) || following.include?(target_user)
  end

  def destroy_follow(target_user_id)
    relationship = Relationship.find_by(follower: id, followed: target_user_id)
    relationship.destroy!
  end

  def destroy_blacklist(target_user_id)
    blacklist = Blacklist.find_by(user_id: id, target_user_id: target_user_id)
    blacklist.destroy!
  end

  def set_access_token(token, secret)
    self.access_token = encrypt(token)
    self.access_token_secret = encrypt(secret)
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new(
        consumer_key: Settings.twitter[:key],
        consumer_secret: Settings.twitter[:secret],
        access_token: decrypt(access_token),
        access_token_secret: decrypt(access_token_secret)
    )
  end

  def refresh_users_info(token, secret)
    set_access_token(token, secret) if access_token_updated?(token, secret) # twitter-developerからaccess_tokenをアップデートする人用の
    self.name = twitter_name
    # self.remote_avatar_url = twitter_avatar if avatar_changed?
    save if changed?
  end

  def twitter_name
    twitter_client.user.name
  end

  def twitter_avatar
    twitter_client.user.profile_image_url_https.to_s
  end

  # デプロイ時にS3を使用しているとエラーになる為、画像は更新しない処理に一旦変更
  # def avatar_changed?
  #   avatar.file.file.split('/').last != twitter_client.user.profile_image_url_https.to_s.split('/').last
  # end

  # 普通はfalse
  def access_token_updated?(token, secret)
    decrypt(access_token) != token || decrypt(access_token_secret) != secret
  end
end
