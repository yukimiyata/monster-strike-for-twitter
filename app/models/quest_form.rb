class QuestForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :body, :string
  attribute :member_capacity, :integer, default: 3
  attribute :recruiting_positions
  attribute :character, :string
  attribute :description, :string
  attribute :recruiting_positions
  attribute :user_id, :integer

  validates :body, presence: true, length: { maximum: 65_535 }
  validates :member_capacity, presence: true
  validates :character, length: { maximum: 255 }
  validates :description, length: { maximum: 255 }

  def save
    # raise ActiveRecord::RecordInvalid if invalid?
    return false if invalid?

    ActiveRecord::Base.transaction do
      post_params = processing_params(body)
      post = Post.new(post_params)
      recruiting_positions.each { |recruit_params| post.recruiting_positions.create(recruit_params) } if post.save
    end
  end

  def processing_params(body)
    begin
    quest_name_base = body.split(/[「|」]/)[1]
    url_base = "monsterstrike-app://joingame/?join=" + body.split(/[「|」]/)[2].split("?pass_code=")[1].split(/[\r|\n]/).first
    { quest_name: quest_name_base, invite_url: url_base, member_capacity: member_capacity, user_id: user_id }
    rescue
    end
  end
end