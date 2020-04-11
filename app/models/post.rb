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

      quest_name_base = body[:body].split(/[「|」]/)[1]
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[「|」]/)[2].split("?pass_code=")[1].split(/[\r | \n]/).first if body[:body].split(/[「|」]/)[2].present?
      member_capacity_base = body[:member_capacity]


      { quest_name: quest_name_base, invite_url: url_base, member_capacity: member_capacity_base }
    rescue => e
      puts 'e'
    end
  end

  def process_api_attributes(body)
    begin

      quest_name_base = body[:body].split(/[「|」]/)[1]
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[「|」]/)[2].split("?pass_code=")[1].split(/[\r | \n]/).first if body[:body].split(/[「|」]/)[2].present?
      member_capacity_base = 1


      { quest_name: quest_name_base, invite_url: url_base, member_capacity: member_capacity_base }
    rescue => e
      puts 'e'
    end
  end

  def set_post_attributes(name, url, count)
    self.quest_name = name
    self.invite_url = url
    self.member_capacity = count
  end
end

