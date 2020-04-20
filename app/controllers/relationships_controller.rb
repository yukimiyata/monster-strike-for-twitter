class RelationshipsController < ApplicationController

  def index
    follower_relationships = Relationship.where(followed_id: current_user.id)
    @posts = follower_relationships.inject([]) { |posts, id| posts << id.follower.latest_post if id.follower.latest_post.waiting? }
    @posts = Kaminari.paginate_array(@posts).page(params[:page])
  end

  def create
    @target_user = User.find(params[:format])
    current_user.destroy_blacklist(@target_user.id) if current_user.blacklisting.include?(@target_user)
    relationship = Relationship.new(follower_id: current_user.id, followed_id: @target_user.id)
    relationship.save!
  end

  def destroy
    @target_user = User.find(params[:id])
    relationship = Relationship.find_by(follower_id: current_user.id, followed_id: @target_user.id)
    relationship.destroy!
  end
end
