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
    @recruiting_position = @post.recruiting_positions.build
  end

  def create
    @post = current_user.posts.new
    @recruiting_position = @post.recruiting_positions.build
    post_params = @post.process_attributes(body_params)
    @post.assign_attributes(post_params)
    if @post.save
      recruiting_position = @post.recruiting_positions.build
      recruit_positions = recruiting_position.to_save_recruit(recruiting_params, body_params[:member_capacity].to_i)
      recruit_positions.each do |r|
        recruiting_position = @post.recruiting_positions.build(character: r[:character], description: r[:description])
        next if recruiting_position.save!

        @post.recruiting_positions.destroy_all
        @post.destroy!
        redirect_to new_post_path
      end
      redirect_to post_path(@post)
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def body_params
    params.require(:post).permit(:body, :member_capacity)
  end

  def recruiting_params
    params.require(:post)[:recruiting_positions]
  end
end
