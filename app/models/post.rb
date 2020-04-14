class Post < ApplicationRecord
  module MyConstant
    MEMBER_CAPACITY_BASE = 1
    MEMBER_CAPACITY_BASE.freeze
  end
  MyConstant.freeze

  belongs_to :user
  has_many :recruiting_positions, dependent: :destroy
  has_many :joined_users, dependent: :destroy

  validates :quest_name, presence: true
  validates :invite_url, presence: true
  validates :member_capacity, presence: true

  scope :recently, -> { where('created_at > ?', 10.hours.ago) }

  enum status: { waiting: 0, started: 1 }

  def process_api_attributes(body)
    begin
      quest_name_base = body[:body].split(/[「|」]/)[1]
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[「|」]/)[2].split("?pass_code=")[1].split(/[\r|\n]/).first
      { quest_name: quest_name_base, invite_url: url_base, member_capacity: MyConstant::MEMBER_CAPACITY_BASE }
    rescue
      { quest_name: nil, invite_url: nil, member_capacity: nil }
    end
  end
end

