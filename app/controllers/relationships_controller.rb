class RelationshipsController < ApplicationController

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
