class Post < ApplicationRecord
  validates :quest_name, presence: true
  validates :invite_url, presence: true
  validates :member_capacity, presence: true

  attr_accessor :body
  belongs_to :user
  has_many :recruiting_positions
  has_many :joined_users

  enum status: { waiting: 0, started: 1 }

  def set_attributes(body)
    begin
      self.quest_name = body[:body].split(/[\r\n|「|」]/)[3]
      url_base = body[:body].split(/[\r\n|「|」]/)[6].split("pass_code=").last
      self.invite_url = "monsterstrike-app://joingame/?join=" + url_base
      self.member_capacity = body[:member_capacity]
    rescue
    end
  end
end

