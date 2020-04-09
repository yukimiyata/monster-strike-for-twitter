class BlacklistsController < ApplicationController
  def create
    @user = User.find(params[:format])
    blacklist = Blacklist.new(user_id: current_user.id, target_user_id: @user.id)
    blacklist.save!
  end

  def destroy
    @user = User.find(params[:id])
    blacklist = Blacklist.find_by(user_id: current_user.id, target_user_id: @user.id)
    blacklist.destroy!
  end
end
