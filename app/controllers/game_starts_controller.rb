class GameStartsController < ApplicationController
  before_action :set_post, only: %w[show starting]

  def show
    @joined_users = @post.recruiting_positions.map(&:joined_user)
    @post.status = :started
    @post.save!
  end

  def starting
    post = Post.find(params[:id])
    redirect_to post.invite_url
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
