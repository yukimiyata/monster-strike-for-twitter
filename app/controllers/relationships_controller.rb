class RelationshipsController < ApplicationController

  def index
    @posts = []
    followed_users_id = Relationship.where(followed_id: current_user.id)
    followed_users_id.each do |user_id|
      @posts << user_id.follower.posts.last if user_id.follower.posts.last.waiting?
    end
  end

  def create
    @user = User.find(params[:format])
    relationship = Relationship.new(follower_id: current_user.id, followed_id: @user.id)
    relationship.save!
  end

  def destroy
    @user = User.find(params[:id])
    relationship = Relationship.find_by(follower_id: current_user.id, followed_id: @user.id)
    relationship.destroy!
  end
end
