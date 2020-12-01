class Post < ApplicationRecord
  module MyConstant
    MEMBER_CAPACITY_BASE = 1
    MEMBER_CAPACITY_BASE.freeze
  end
  MyConstant.freeze

  belongs_to :user
  has_many :recruiting_positions, dependent: :destroy
  has_many :joined_users, dependent: :destroy

  validates :quest_name, presence: true, length: { maximum: 30 }
  validates :invite_url, presence: true, length: { maximum: 50 }
  validates :member_capacity, presence: true, length: { maximum: 1 }
  validate :user_game_name_present?, on: %i[new create]

  scope :recently, -> { where('created_at > ?', 10.hours.ago) }

  enum status: { waiting: 0, started: 1 }

  def user_game_name_present?
    errors.add(:game_name, 'モンストネームが存在しません') if user.game_name.blank?
  end

  def process_api_attributes(body)
    begin
      quest_name_base = body[:body].split(/[「|」]/)[1]
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[「|」]/)[2].split("?pass_code=")[1].split(/[\r|\n]/).first
      { quest_name: quest_name_base, invite_url: url_base, member_capacity: MyConstant::MEMBER_CAPACITY_BASE }
    rescue
      { quest_name: nil, invite_url: nil, member_capacity: nil }
    end
  end

  def include_joined?(current_user)
    return true if current_user.id == user_id || joined_users.any?{ |u| u.user.id == current_user.id }

    false
  end
end

