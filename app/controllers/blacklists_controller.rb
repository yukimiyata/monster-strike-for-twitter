class BlacklistsController < ApplicationController
  before_action :valid_block?, only: :create

  def create
    joined_user = JoinedUser.find(params[:format])
    @joined_users = joined_user.post.recruiting_positions.map(&:joined_user)
    blacklist = Blacklist.new(user_id: current_user.id, target_user_id: joined_user.user.id)
    blacklist.save!
  end

  def destroy
    joined_user = JoinedUser.find(params[:id])
    @joined_users = joined_user.post.recruiting_positions.map(&:joined_user)
    blacklist = Blacklist.find_by(user_id: current_user.id, target_user_id: joined_user.user.id)
    blacklist.destroy!
  end

  private

  def valid_block?
    block_user = JoinedUser.find(params[:format]).user
    render 'game_starts/new' if current_user.blacklisting.include?(block_user) || current_user.following.include?(block_user)
  end
end
