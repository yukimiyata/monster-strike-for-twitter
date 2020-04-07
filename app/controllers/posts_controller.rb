class PostsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: %i[index show]

  def new
    @post = current_user.posts.new
  end

  def index
    @posts = Post.all
  end

  def create
    @post = current_user.posts.new
    @post.set_attributes(body_params)
    if @post.save
      redirect_to create_post_content_path(@post)
    else
      byebug
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @recruits = @post.recruits
  end

  # def create_post_content
  #   @post = Post.find(params[:format])
  #   session[:post_id] = @post.id
  #   @post.member_count.times { @recruit = @post.recruits.new }
  # end

  private

  def body_params
    params.require(:post).permit(:body, :member_count)
  end
end
