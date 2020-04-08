class GameStartsController < ApplicationController
  before_action :set_post, only: :new
  before_action :post_user_valid?, only: :new

  def new
    @joined_users = @post.recruiting_positions.map(&:joined_user)
    @post.status = :started
    @post.save!
  end

  def show
    post = Post.find(params[:id])
    redirect_to post.invite_url
  end

  private

  def set_post
    @post = Post.find(params[:format])
  end

  def post_user_valid?
    render 'posts#show' if current_user.id != @post.user_id
  end
end
