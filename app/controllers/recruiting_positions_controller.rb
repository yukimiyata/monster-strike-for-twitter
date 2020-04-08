class RecruitingPositionsController < ApplicationController
  before_action :require_login

  def new
    @post = Post.find(params[:format])
    session[:post_id] = @post.id
    @post.member_capacity.times { @recruiting_position = @post.recruiting_positions.new }
  end

  def create
    post = current_user.posts.find(session[:post_id])
    post.member_capacity.times do |index|
      character = character_params[index][:character]
      description = description_params[index][:description]
      recruiting_position = post.recruiting_positions.build(character: character, description: description)
      if recruiting_position.save
        continue
      else
        flash.now[:danger] = '登録出来ませんでした'
        render :new
      end
    end
    redirect_to post_path(post.id), success: '投稿しました'
  end

  private

  def character_params
    params.require(:recruiting_position).permit(recruiting_positions: :character)[:recruiting_positions]
  end

  def description_params
    params.require(:recruiting_position).permit(recruiting_positions: :description)[:recruiting_positions]
  end
end
