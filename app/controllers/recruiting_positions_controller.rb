class RecruitingPositionsController < ApplicationController
  before_action :require_login

  def new
    @post = current_user.posts.new
    @recruiting_position = @post.recruiting_positions.new
    @quest_name = params[:quest_name]
    @invite_url = params[:invite_url]
    @member_capacity = params[:member_capacity].to_i
  end

  def create
    post = current_user.posts.new
    post.set_save_post(quest_name_params, invite_url_params, member_capacity_params)
    post.save!

    recruiting_positions_params.count.times do |index|
      character = recruiting_positions_params[index][:character]
      description = recruiting_positions_params[index][:description]
      recruiting_position = post.recruiting_positions.build(character: character, description: description)
      next if recruiting_position.save

      flash.now[:danger] = '登録出来ませんでした'
      post.destroy!
      redirect_to new_post_path
    end

    redirect_to post_path(post.id)
  end

  private

  def quest_name_params
    params.require(:quest_name)
  end

  def invite_url_params
    params.require(:quest_name)
  end

  def member_capacity_params
    params.require(:member_capacity)
  end

  def recruiting_positions_params
    params.require(:post)[:recruiting_positions]
  end

end
