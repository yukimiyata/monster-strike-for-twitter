class Post < ApplicationRecord
  validates :quest_name, presence: true
  validates :invite_url, presence: true
  validates :member_capacity, presence: true
  attr_accessor :body

  belongs_to :user
  has_many :recruiting_positions, dependent: :destroy
  has_many :joined_users, dependent: :destroy

  enum status: { waiting: 0, started: 1 }

  def process_attributes(body)
    begin
      quest_name_base = body[:body].split(/[\r\n|「|」]/)[3]
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[\r\n|「|」]/)[6].split("pass_code=").last
      member_capacity_base = body[:member_capacity]

      post_value = { quest_name: quest_name_base, invite_url: url_base, member_capacity: member_capacity_base }
    rescue
    end
  end

  def set_post_attributes(name, url, count)
    self.quest_name = name
    self.invite_url = url
    self.member_capacity = count
  end
end

