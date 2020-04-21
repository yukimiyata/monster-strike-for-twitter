class JoinedUsersController < ApplicationController
  before_action :set_recruiting_position
  before_action :check_exist_user?, only: :create
  before_action :invalid_to_join_yourself
  before_action :block_to_join_or_unjoin_started_post
  before_action :block_to_blacklisted_user_join
  before_action :require_game_name, only: %w[create]
  before_action :already_waiting_joined, only: :create
  before_action :redirect_if_users_post_waiting, only: :create

  def create
    post = @recruiting_position.post
    joined_user = current_user.joined_user.new
    joined_user.join_quest(params[:id], post.id)
    joined_user.save!
    redirect_to post_path(post)
  end

  def destroy
    @recruiting_position.joined_user.destroy!
    redirect_to post_path(@recruiting_position.post)
  end

  private

  def require_game_name
    redirect_to edit_user_path(current_user), danger: 'モンスト内のネームを登録してください' if current_user.game_name.blank?
  end

  def set_recruiting_position
    @recruiting_position = RecruitingPosition.find(params[:id])
  end

  def check_exist_user?
    redirect_to post_path(@recruiting_position.post) if @recruiting_position.joined_user.present?
  end

  def invalid_to_join_yourself
    redirect_to post_path(@recruiting_position.post) if @recruiting_position.post.user_id == current_user.id
  end

  def block_to_join_or_unjoin_started_post
    redirect_to root_path if @recruiting_position.post.started?
  end

  def block_to_blacklisted_user_join
    return unless @recruiting_position.post.user.blacklisting.include?(current_user)

    flash[:danger] = '入室が許可されていません'
    redirect_to root_path
  end

  def already_waiting_joined
    redirect_to post_path(current_user.joined_user.last.post), danger: '参加中のクエストがあります' if current_user.joined_user.present? && current_user.joined_user.last.post.waiting?
  end

  def redirect_if_users_post_waiting
    redirect_to post_path(current_user.latest_post), danger: '募集中のクエストがあります' if current_user.latest_post.present? && current_user.latest_post.waiting?
  end
end
