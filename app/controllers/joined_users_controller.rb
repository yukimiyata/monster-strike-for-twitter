class JoinedUsersController < ApplicationController
  before_action :set_recruiting_position
  before_action :check_exist_user?, only: :create

  def create
    post = @recruiting_position.post
    joined_user = current_user.joined_user.new
    joined_user.join_quest(params[:id], post.id)
    joined_user.save!
  end

  def destroy
    @recruiting_position.joined_user.destroy!
  end

  private

  def set_recruiting_position
    @recruiting_position = RecruitingPosition.find(params[:id])
  end

  def check_exist_user?
    render 'posts/show' if @recruiting_position.joined_user.present?
  end
end
