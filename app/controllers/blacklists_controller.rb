class BlacklistsController < ApplicationController

  def create
    @target_user = User.find(params[:format])
    current_user.destroy_follow(@target_user.id) if current_user.following.include?(@target_user)
    blacklist = Blacklist.new(user_id: current_user.id, target_user_id: @target_user.id)
    blacklist.save!
  end

  def destroy
    @target_user = User.find(params[:id])
    blacklist = Blacklist.find_by(user_id: current_user.id, target_user_id: @target_user.id)
    blacklist.destroy!
  end
end
