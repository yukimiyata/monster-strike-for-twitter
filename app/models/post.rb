class Post < ApplicationRecord
  validates :quest_name, presence: true
  validates :invite_url, presence: true
  validates :member_capacity, presence: true
  attr_accessor :body

  belongs_to :user
  has_many :recruiting_positions, dependent: :destroy
  accepts_nested_attributes_for :recruiting_positions, reject_if: :all_blank, allow_destroy: true
  has_many :joined_users, dependent: :destroy

  enum status: { waiting: 0, started: 1 }

  def set_attributes(body)
    begin
      quest_name_base = body[:body].split(/[\r\n|「|」]/)[3]
      self.quest_name = quest_name_base
      url_base = "monsterstrike-app://joingame/?join=" + body[:body].split(/[\r\n|「|」]/)[6].split("pass_code=").last
      self.invite_url = url_base
      member_capacity_base = body[:member_capacity]
      self.member_capacity = member_capacity_base

      post_value = [quest_name_base, url_base, member_capacity_base]
      post_value
    rescue
    end
  end

  def set_save_post(name, url, count)
    self.quest_name = name
    self.invite_url = url
    self.member_capacity = count
  end
end

