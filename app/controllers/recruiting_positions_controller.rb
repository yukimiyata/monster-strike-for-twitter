class RecruitingPositionsController < ApplicationController
  before_action :require_login
  # def create
  #   post = current_user.posts.find(session[:post_id])
  #   post.member_count.times do |index|
  #     character = character_params[index][:character]
  #     description = description_params[index][:description]
  #     recruit = post.recruits.build(character: character, description: description)
  #     recruit.save
  #   end
  #   redirect_to post_path(post.id), success: '投稿しました'
  # end

  private

  def character_params
    params.require(:recruit).permit(recruits: :character)[:recruits]
  end

  def description_params
    params.require(:recruit).permit(recruits: :description)[:recruits]
  end
end
