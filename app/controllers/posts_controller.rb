class PostsController < ApplicationController
  skip_before_action :require_login, only: %w[index]
  before_action :require_game_name, only: %w[new create]
  before_action :set_post, only: %w[show]
  before_action :block_to_blacklisted_user_join, only: %w[show]
  before_action :last_post_waiting?, only: %w[new create]
  before_action :redirect_if_started_post, only: :show

  def index
    @posts = if logged_in?
               # Post.recently.includes(:user).where.not(user_id: current_user.blacklisted).order(created_at: :desc).page(params[:page])
               Post.all.order(created_at: :desc).page(params[:page])
             else
               Post.recently.includes(:user).page(params[:page])
             end
  end

  def show
    @recruiting_positions = @post.recruiting_positions
  end

  def new
    @quest_form = QuestForm.new(tweet_post: 1)
  end

  def create
    @quest_form = QuestForm.new(quest_form_params.merge(user_id: current_user.id))
    if @quest_form.save
      current_user.twitter_client.update(current_user.latest_post.quest_name + "https://monbirds.com/posts/#{current_user.latest_post.id}") if @quest_form.tweet_post == 1
      redirect_to post_path(current_user.latest_post)
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def quest_form_params
    params.require(:quest_form).permit(:body, :member_capacity, :user_id, :tweet_post, recruiting_positions: [:character, :description])
  end

  def require_game_name
    redirect_to edit_user_path(current_user), danger: 'モンスト内のネームを登録してください' if current_user.game_name.blank?
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def block_to_blacklisted_user_join
    return unless @post.user.blacklisting.include?(current_user)

    flash[:danger] = '入室が許可されていません'
    redirect_to root_path
  end

  def last_post_waiting?
    redirect_to post_path(current_user.latest_post), danger: '募集中のクエストがあります' if current_user.latest_post.present? && current_user.latest_post.waiting?
  end

  def redirect_if_started_post
    redirect_to game_start_path(@post), info: '募集済です' if @post.user_id == current_user.id && @post.started?
  end
end
