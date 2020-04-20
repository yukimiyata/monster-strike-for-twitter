class GameStartsController < ApplicationController
  before_action :set_post, only: %w[show starting]
  before_action :post_owner?, only: %w[show]
  before_action :allowed_user_to_start?, only: %w[starting]

  def show
    @joined_users = @post.recruiting_positions.map(&:joined_user)
    @post.status = :started
    @post.save!
  end

  def starting
    redirect_to @post.invite_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_owner?
    redirect_to root_path unless @post.user_id == current_user.id
  end

  def allowed_user_to_start?
    redirect_to root_path, danger: '入室が許可されていません' unless @post.include_joined?(current_user)
  end
end
