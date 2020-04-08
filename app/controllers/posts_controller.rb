class PostsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: %i[index show]

  def new
    @post = current_user.posts.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @recruiting_positions = @post.recruiting_positions
  end

  def create
    @post = current_user.posts.new
    @post.set_attributes(body_params)
    if @post.save
      redirect_to new_recruiting_position_path(@post)
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
