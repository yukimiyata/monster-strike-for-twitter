class RelationshipsController < ApplicationController
  before_action :valid_follow?, only: :create

  def index
    follower_ids = Relationship.where(followed_id: current_user.id)
    @posts = follower_ids.inject([]) { |posts, id| posts << id.follower.posts.last if id.follower.posts.last.waiting? }
  end

  def create
    joined_user = JoinedUser.find(params[:format])
    @joined_users = joined_user.post.recruiting_positions.map(&:joined_user)
    relationship = Relationship.new(follower_id: current_user.id, followed_id: joined_user.user.id)
    relationship.save!
  end

  def destroy
    joined_user = JoinedUser.find(params[:id])
    @joined_users = joined_user.post.recruiting_positions.map(&:joined_user)
    relationship = Relationship.find_by(follower_id: current_user.id, followed_id: joined_user.user.id)
    relationship.destroy!
  end

  private

  def valid_follow?
    follow_user = JoinedUser.find(params[:format]).user
    render 'game_starts/new' if current_user.blacklisting.include?(follow_user) || current_user.following.include?(follow_user)
  end
end
