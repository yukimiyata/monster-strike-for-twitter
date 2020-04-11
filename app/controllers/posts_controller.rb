class PostsController < ApplicationController
  skip_before_action :require_login, only: %w[index]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @recruiting_positions = @post.recruiting_positions
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new
    post_value = @post.set_attributes(body_params)
    if @post.valid?
      redirect_to new_recruiting_position_path(quest_name: post_value[0], invite_url: post_value[1], member_capacity: post_value[2])
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def body_params
    params.require(:post).permit(:body, :member_capacity)
  end
end
