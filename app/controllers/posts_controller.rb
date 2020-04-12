class PostsController < ApplicationController
  skip_before_action :require_login, only: %w[index]

  def index
    @posts = Post.recently.includes(:user).where.not(user_id: current_user.blacklisted)
  end

  def show
    @post = Post.find(params[:id])
    @recruiting_positions = @post.recruiting_positions
  end

  def new
    @quest_form = QuestForm.new
  end

  def create
    @quest_form = QuestForm.new(quest_form_params)
    if @quest_form.save
      redirect_to post_path(current_user.posts.last)
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def quest_form_params
    params.require(:quest_form).permit(:body, :member_capacity, :user_id, recruiting_positions: [:character, :description])
  end
end
